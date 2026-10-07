-- build.lua for ugentdocs (l3build)
--
--   l3build unpack     -> docstrip only; classes in ./build/unpacked
--   l3build doc        -> ugentdocs.pdf
--   l3build examples   -> all example-*.tex, including generated covers
--   l3build release    -> ./ugentdocs-<version>.zip (GitHub release)
--   l3build ctan       -> ./ugentdocs-<version>-ctan.zip (CTAN upload)
--   l3build clean      -> removes all of the above and ./build
--   l3build install    -> install into TEXMFHOME for local testing
--
-- Version: $UGENTDOCS_VERSION, else the Git tag on HEAD (leading "v"
-- stripped), else "dev".

module = "ugentdocs"

local lfs = require("lfs")

local upstream_tag = "uantwerpendocs-v4.12-code"
local repo_url     = "https://github.com/SeppeOngena/ugentdocs"

-- Helpers ------------------------------------------------------------------

local function capture(cmd)
  local f = io.popen(cmd)
  if not f then return "" end
  local out = f:read("*a") or ""
  f:close()
  return out
end

local function trim(s) return (s:gsub("^%s+", ""):gsub("%s+$", "")) end

local function readfile(name)
  local f = assert(io.open(name, "rb"))
  local s = f:read("*a")
  f:close()
  return s
end

local function writefile(name, s)
  local f = assert(io.open(name, "wb"))
  f:write(s)
  f:close()
end

-- Version ------------------------------------------------------------------
-- 1. l3build release|ctan|upload <version>   (e.g. "l3build ctan v1.2.0")
-- 2. $UGENTDOCS_VERSION
-- 3. Git tag on HEAD
-- 4. dev-<short hash>, or "dev" without Git
-- The version is used as given (v1.2.0) everywhere except the CTAN upload
-- form, where the leading "v" is dropped (1.2.0), as is usual on CTAN.

local function git(args)
  return trim(capture("git " .. args .. " 2>" .. os_null))
end

local has_git = git("rev-parse --git-dir") ~= ""

local versioned_targets = { release = true, ctan = true, upload = true }
local cli = versioned_targets[options.target] and options.names
  and options.names[1] or nil

local version = cli or os.getenv("UGENTDOCS_VERSION") or ""
if version == "" and has_git then
  version = git("describe --tags --exact-match")
end
if version == "" then
  local hash = has_git and git("rev-parse --short HEAD") or ""
  version = hash ~= "" and ("dev-" .. hash) or "dev"
end

local ctanversion = (version:gsub("^v", ""))
-- upload takes the CTAN version from the command line
if cli and options.target == "upload" then options.names[1] = ctanversion end

-- Fonts: Panno is not redistributable, so it is picked up from ./Fonts ------

local fontdir = os.getenv("FONT_DIR") or "Fonts"
if lfs.attributes(fontdir, "mode") == "directory" then
  local path = fontdir:match("^%a:") and fontdir
    or (lfs.currentdir() .. "/" .. fontdir)
  os.setenv("OSFONTDIR", path:gsub("\\", "/") .. "//")
end

-- Files --------------------------------------------------------------------

sourcefiles  = {"ugentdocs.dtx", "ugentdocs.ins", "Images"}
installfiles = {"*.cls", "*.sty", "*.clo", "*.dict", "Images"}
typesetfiles = {"ugentdocs.dtx"}

typesetexe   = "lualatex"
typesetcmds  = "\\def\\ugentdocsversion{" .. version .. "}"

-- README and CHANGELOG are generated (see ctan pre-hook below)
textfiledir  = "./build/text"
textfiles    = {"README-ctan.md", "CHANGELOG.md"}
ctanreadme   = "README-ctan.md"   -- renamed to README.md in the CTAN zip
cleanfiles   = {"*.log", "*.pdf", "*.zip", "*.curlopt"}
ctanzip      = "ugentdocs-" .. version .. "-ctan"

-- Generated text files -------------------------------------------------------

local function generate_changelog(output)
  local out = { readfile("ctan/CHANGELOG-header.md"), "\n" }
  local log = ""
  if has_git then
    local fmt = "%ad%x1f%H%x1f%s%x1f%an%x1f%b%x1e"
    log = capture('git log --reverse --no-merges --date=short --format="'
      .. fmt .. '" ' .. upstream_tag .. "..HEAD 2>" .. os_null)
  end
  if log == "" then
    print("Warning: no Git history found; CHANGELOG.md has no development "
      .. "history")
    out[#out + 1] = "The development history could not be generated for "
      .. "this build.\n"
  end
  for entry in log:gmatch("([^\30]+)\30") do
    local date, hash, subject, author, body =
      entry:match("^%s*(.-)\31(.-)\31(.-)\31(.-)\31(.*)$")
    if date then
      out[#out + 1] = "## " .. date .. " — `" .. hash .. "`\n\n"
        .. "### " .. subject .. "\n\n"
        .. "**Author:** " .. author .. "\n\n"
        .. body .. "\n"
    end
  end
  out[#out + 1] = "\nThe complete development history is available in the "
    .. "Git repository:\n\n" .. repo_url .. "\n"
  writefile(output, table.concat(out))
end

local function generate_ctanreadme(output)
  local s = readfile("ctan/README.md")
  s = s:gsub("@VERSION@", version):gsub("@DATE@", os.date("%Y-%m-%d"))
  writefile(output, s)
end

local function generate_textfiles()
  mkdir(textfiledir)
  generate_changelog(textfiledir .. "/CHANGELOG.md")
  generate_ctanreadme(textfiledir .. "/README-ctan.md")
  return 0
end

-- Example sources and .cfg files are generated by docstrip. The
-- documentation \VerbatimInput's the examples, so they must sit next to
-- ugentdocs.dtx in the typeset directory.
function docinit_hook()
  for _, glob in ipairs({"example-*.tex", "*.cfg"}) do
    cp(glob, unpackdir, typesetdir)
  end
  return 0
end

-- Examples -----------------------------------------------------------------

local exampledir = "./build/examples"
local examplefiles = {"example-*.tex", "beamerthemeugentuserguide.tex", "*.cfg"}

-- Typeset every .tex file until no new ones appear: \generatebookcover
-- writes <jobname>-cover.tex during the first pass of its parent example.
local function examples()
  local errorlevel = unpack()
  if errorlevel ~= 0 then return errorlevel end
  cleandir(exampledir)
  for _, glob in ipairs(examplefiles) do
    cp(glob, unpackdir, exampledir)
  end
  cp("Images", unpackdir, exampledir)
  local done = {}
  repeat
    local found = false
    for _, file in ipairs(filelist(exampledir, "*.tex")) do
      if not done[file] then
        print("Typesetting " .. file)
        errorlevel = typeset(file, exampledir)
        if errorlevel ~= 0 then
          print(" ! Compilation of " .. file .. " failed")
          return errorlevel
        end
        done[file] = true
        found = true
      end
    end
  until not found
  return 0
end

-- GitHub release zip ---------------------------------------------------------
--   ugentdocs/ugentdocs/  class files
--   ugentdocs/examples/   example sources and PDFs
--   ugentdocs/ ugentdocs.pdf, CHANGELOG.md, README.md, and LICENSE

local textext = { tex = true, cls = true, sty = true, clo = true, dict = true,
  cfg = true, md = true, dtx = true, ins = true, txt = true }

local function release()
  local errorlevel = doc()
  if errorlevel ~= 0 then return errorlevel end
  errorlevel = examples()
  if errorlevel ~= 0 then return errorlevel end

  local root = "./build/release"
  local pkg  = root .. "/ugentdocs"
  rmdir(root)
  mkdir(pkg .. "/ugentdocs")
  mkdir(pkg .. "/examples")
  for _, glob in ipairs(installfiles) do
    cp(glob, unpackdir, pkg .. "/ugentdocs")
  end
  cp("ugentdocs.pdf", typesetdir, pkg)
  cp("README.md", ".", pkg)
  cp("LICENSE*", ".", pkg)
  for _, glob in ipairs(examplefiles) do
    cp(glob, exampledir, pkg .. "/examples")
  end
  cp("*.pdf", exampledir, pkg .. "/examples")
  generate_changelog(pkg .. "/CHANGELOG.md")

  local zipname = "./ugentdocs-" .. version .. ".zip"
  os.remove(zipname)
  local zip = assert(require("l3build-zip")(zipname))
  for _, p in ipairs(tree(root, "**")) do
    if lfs.attributes(p.cwd, "mode") == "file" then
      local ext = (p.src:match("%.(%w+)$") or ""):lower()
      zip:add(p.cwd, p.src:sub(3), not textext[ext])
    end
  end
  zip:close()
  print("Built " .. zipname)
  return 0
end

-- CTAN upload: l3build upload <version> --file ctan/announcement.md ---------

uploadconfig = {
  pkg         = "ugentdocs",
  version     = ctanversion,
  author      = "Seppe Ongena",
  -- uploader and email are left out on purpose: l3build asks for them
  license     = "lppl1.3c",
  summary     = "House style document classes for Ghent University",
  description = "This package implements the house style of Ghent University "
  .. "(version 2025, see the official style guide) for bachelor's, master's, "
  .. "and PhD dissertations, research articles, reports (e.g., meeting minutes, "
  .. "course assignments), exams, letters, course notes, and beamer slides, and "
  .. "generates print-ready book covers for PhD dissertations and courses. "
  .. "Dutch and English are oddicially supported. The package requires LuaLaTeX "
  .. "or XeLaTeX due to the use of the official UGent fonts.",
  ctanPath    = "/macros/latex/contrib/ugentdocs",
  home        = repo_url,
  repository  = repo_url,
  bugtracker  = repo_url .. "/issues",
  support     = repo_url .. "/discussions",
  development = repo_url .. "/blob/HEAD/CONTRIBUTING.md",
  update      = true,
}

-- Targets ------------------------------------------------------------------

target_list.examples = {
  desc = "Typesets the example documents",
  func = examples,
}
target_list.release = {
  desc = "Builds the GitHub release zip",
  func = release,
}
target_list.ctan.pre = generate_textfiles

-- The standard clean only empties l3build's own folders and leaves
-- subfolders (Images/) and the folders created above; remove ./build entirely
local stdclean = target_list.clean.func
target_list.clean.func = function(names)
  return stdclean(names) + rmdir(builddir)
end
