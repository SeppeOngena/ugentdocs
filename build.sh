#!/bin/bash
# Usage:
#   ./build.sh              -> Full build, version "dev"
#   ./build.sh 1.2.0        -> Full build, version "1.2.0"
#   ./build.sh --test       -> Test build: just runs the .ins
#                              Drops the stripped class files into a flat ./build/ folder
#                              No .dtx doc or example .tex build, no release zip
#
# Full build produces ./build/ugentdocs-<version>.zip containing:
#   ugentdocs/     -> All class files for installation in tex/latex/ package directory
#   ugentdocs.pdf  -> Documentation
#   examples/      -> .tex and compiled pdfs of examples
#                       (usage requires ugentdocs package install or
#                       moving the .tex file one folder up so
#                       it can see the classes in subdirectories)
#

set -euxo pipefail

# Changelog generation
generate_changelog() {
  local output="$1"
  local upstream_tag="uantwerpendocs-v4.12-code"

  {
    echo "# Changelog"
    echo
    echo "## Derived from uantwerpendocs v4.12"
    echo
    echo "This work was derived from the \`uantwerpendocs\` v4.12 code,"
    echo "preserved at the Git tag \`$upstream_tag\`."
    echo
    cat <<'EOF'
The original source was substantially modified and expanded
for the UGent house style. The major changes include:

- Renaming, restructuring, and merging of the classes and large portions of
  the code, and removal of legacy and unused code:
  - `uantwerpenphdthesis` → `ugentphd`
  - `uantwerpenbamathesis` → `ugentbama`
  - `uantwerpenreport` → `ugentreport`
  - `uantwerpencoursetext` → `ugentcourse`
  - `uantwerpenletter` → `ugentletter`
  - `uantwerpenexam` → `ugentexam`
  - `beamerthemeuantwerpen` → `beamerthemeugent`
  - new: `ugentbookcover` and `ugentarticle`
- Migration of class options (key–value, e.g. `faculty=bw`, `campus=kortrijk`,
  `colormodel=cmyk`) and most internals to LaTeX3 (expl3), dropping the
  xstring, xparse, and ifthen packages.
- Reworked dictionary handling: `\translatekey` with casing and expansion
  options, support for empty lines and a `__NEWLINE__` placeholder in `.dict`
  files, and improved babel compatibility (in-document switching via
  `\selectlanguage`).
- Reworked logo handling. No images are used, only TikZ paths (converted from
  the official EPS files) and text, for the UGent logo, all faculty logos,
  GUGC, and campus Kortrijk, plus standalone UGent and faculty icons. The
  faculty may be omitted entirely.
- UGent font handling: UGent Panno Text is required for the logos (and hence
  LuaLaTeX or XeLaTeX), with Arial as option. Noto Sans Math is used with
  TeX Gyre DejaVu Math as fallback. Fake small caps were implemented
  for fontspec fonts.
- Unified handling of people and document data through generalised sequences
  (authors, lecturers, supervisors, tutors, jury members, degrees, contact),
  including indexed affiliations, corresponding authors, e-mail and
  ORCID, a unified `\embargo` macro, localised dates via `localizedates`,
  word counts via texcount, and warnings for missing mandatory macros.
- Reworked book-cover generation. A separate `ugentbookcover` class prints
  covers from command inputs instead of relying on PDF inputs, including an
  automatic ISBN barcode; `\generatebookcover` now creates a more
  structured cover file directly from the main document.
- Integration of UGent-specific covers and title pages following the official
  grid, adding colophons, copyright, confidentiality and embargo notices with
  signature fields, headers and footers, chapter thumbs, and five chapter
  title styles.
- New `ugentarticle` class; a reworked beamer theme (16:9 grid geometry,
  a single configurable graphic frame, title and section graphics, title
  logos, closing frame); and a reworked exam class (subquestions, point
  overview, answer spaces with grid or line fills spilling to the next page).
- Build and release tools: local build script, GitHub Actions workflow,
  encrypted fonts for CI builds, and an auto-generated changelog.
- Extensive changes to documentation and examples, including an index,
  copy-pasteable code blocks, customisation notes, deduplicated examples,
  and a short LaTeX tutorial.

The detailed development history below is generated from Git.

## Development history

EOF

    git log --reverse --no-merges \
      --format='## %ad — `%H`%n%n### %s%n%n**Author:** %an%n%n%b%n' \
      --date=short \
      "$upstream_tag..HEAD"

    echo
    echo "The complete development history is available in the Git repository:"
    echo
    echo "https://github.com/SeppeOngena/ugentdocs/"
  } > "$output"
}

# 1. Argument parse and tmp folder setup

TEST=false
IMG=false
COMPILER="lualatex"
VERSION="dev"

for arg in "$@"; do
  case "$arg" in
    --test) TEST=true ;;
    --images) IMG=true ;;
    --lualatex) COMPILER="lualatex";;
    --xelatex) COMPILER="xelatex";;
    *) VERSION="$arg" ;;
  esac
done

ROOT="$(pwd)"

if [ "$TEST" = false ]; then
  TMP="./build/_tmp"
else
  TMP="./build"
fi

FONT_DIR="${FONT_DIR:-./Fonts}"
if [ -d "$FONT_DIR" ]; then
  export OSFONTDIR="$(cd "$FONT_DIR" && pwd)//"
fi

rm -rf ./build
mkdir -p "$TMP"

cp ugentdocs.dtx ugentdocs.ins "$TMP/"
cp -a ./Images/. "$TMP/Images"

pushd "$TMP" >/dev/null


# 2. Docstrip and build pdfs

# 2.1 Docstrip the class files from the .dtx using the .ins
"$COMPILER" -interaction=nonstopmode -halt-on-error ugentdocs.ins

if [ "$TEST" = false ]; then
  # 2.2 Build the documentation
  "$COMPILER" -interaction=nonstopmode -halt-on-error "\def\ugentdocsversion{$VERSION}\input{ugentdocs.dtx}"
  makeindex -s gind.ist ugentdocs.idx
  "$COMPILER" -interaction=nonstopmode -halt-on-error "\def\ugentdocsversion{$VERSION}\input{ugentdocs.dtx}"
  "$COMPILER" -interaction=nonstopmode -halt-on-error "\def\ugentdocsversion{$VERSION}\input{ugentdocs.dtx}"

  # 2.3 Build every example .tex file
  declare -A built
  while true; do # "dynamic" to support dissertation covers
    found_new=false
    for f in *.tex; do
      [ -f "$f" ] || continue
      [ -n "${built[$f]:-}" ] && continue
      "$COMPILER" -interaction=nonstopmode -halt-on-error "$f"
      if [ -f "${f%.tex}.bcf" ]; then
        biber "${f%.tex}"
      fi
      "$COMPILER" -interaction=nonstopmode -halt-on-error "$f"
      "$COMPILER" -interaction=nonstopmode -halt-on-error "$f"
      built["$f"]=1
      found_new=true
    done
    [ "$found_new" = true ] || break
  done
fi

popd >/dev/null


# 3. Folder structure

# 3.1 Test build, just flat copy for ease of iterative testing, no zip
if [ "$TEST" = true ]; then
  echo "Test build complete"
  exit 0
fi

# 3.2 Full build: move results into release layout
DIST="ugentdocs-${VERSION}"
mkdir -p "./build/${DIST}/ugentdocs" "./build/${DIST}/examples"
generate_changelog "./build/${DIST}/CHANGELOG.md"


mv "$TMP"/*.cls    "./build/${DIST}/ugentdocs/" 2>/dev/null || true
mv "$TMP"/*.sty    "./build/${DIST}/ugentdocs/" 2>/dev/null || true
mv "$TMP"/*.dict   "./build/${DIST}/ugentdocs/" 2>/dev/null || true
mv "$TMP"/*.clo    "./build/${DIST}/ugentdocs/" 2>/dev/null || true
mv "$TMP"/Images/  "./build/${DIST}/ugentdocs/" 2>/dev/null || true

mv "$TMP/ugentdocs.pdf" "./build/${DIST}/" 2>/dev/null || true

for f in "$TMP"/*.pdf; do
  [ -f "$f" ] || continue
  mv "$f" "./build/${DIST}/examples/"
done

for f in "$TMP"/example-*.tex; do
  [ -f "$f" ] || continue
  mv "$f" "./build/${DIST}/examples/"
done

mv "$TMP"/*.cfg "./build/${DIST}/examples/" 2>/dev/null || true

# 3.3 Remove tmp dir
rm -rf "$TMP"

# 3.4
if [ "$IMG" = true ]; then
  mkdir -p "./build/${DIST}/examples/images"
  for f in "./build/${DIST}/examples/"*.pdf; do
      [ -f "$f" ] || continue
      base="$(basename "$f" .pdf)"
      pdftoppm -png -r 300 "$f" "./build/${DIST}/examples/images/${base}"
  done
fi

# 4.0 Build zip for release attach
cd ./build
zip -r "${DIST}.zip" "${DIST}"
cd "$ROOT"

echo "Built ./build/${DIST}.zip"
