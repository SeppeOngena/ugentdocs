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

# CTAN readme generation
generate_ctanreadme() {
  local output="$1"
  local br="  "

  cat > "$output" <<EOF
ugentdocs: House style document classes for Ghent University
====================================================================

Release $(date -I) v$VERSION

Overview
--------

This package implements the house style of Ghent University (version 2025)
for MSc/BSc/PhD dissertations, research articles, reports (meeting notes or
course assignments), exams, letters, course notes, and slides (beamer).
These class files allow you to make and keep most of your document needs
compliant to this version and future versions of the UGent house style.

If you think (1) there's an error in compliance with regards to the house
style, (2) there's a feature missing in the classes or beamer theme, or
(3) there's a bug in this package, please,
[open an issue on GitHub](https://github.com/SeppeOngena/ugentdocs)
or contact me via email
( [seppe.ongena@ugent.be](mailto:seppe.ongena@ugent.be) )

License
-------

This work is derived from uantwerpendocs v4.12 by Walter Daems,
which was substantially modified and expanded for the UGent house style.
A complete, unmodified copy of the original work is available at

   https://ctan.org/tex-archive/macros/latex/contrib/uantwerpendocs

Code for the styling and GAI disclaimer from Joris Meys' LaTeX at UGent
was adapted with permission and used for the bama and report classes.
In addition to renaming classes and updating everything to UGent style,
changes include, but are not limited to: a move to LaTeX3 key-value
options, rework of dictionary handling, complete rewrite of logo input,
rework of bookcover generation, unified handling of authors and
affiliations, new article and bookcover classes, and the restructuring,
unification, and merging of large chunks of code.
A complete and accurate development history is included in CHANGELOG.md.
The underlying Git repository and full commit history are available at:

  https://github.com/SeppeOngena/ugentdocs/

This work may be distributed and/or modified under the conditions of
the LaTeX Project Public License, either version 1.3 of this license
or (at your option) any later version.  The latest version of this
license is in:

  http://www.latex-project.org/lppl.txt

and version 1.3 or later is part of all distributions of LaTeX
version 2005/12/01 or later.

Developers
----------------

This package is developed and maintained by
[Seppe Ongena](mailto:seppe.ongena@ugent.be).

-----

© 2013-2026 Walter Daems$br
© 2017-2026 Joris Meys$br
© 2026 Seppe Ongena$br
All rights reserved.
EOF
}

# 1. Argument parse and tmp folder setup

TEST=false
IMG=false
CTAN=false
COMPILER="lualatex"
VERSION="dev"

for arg in "$@"; do
  case "$arg" in
    --test) TEST=true ;;
    --images) IMG=true ;;
    --lualatex) COMPILER="lualatex";;
    --xelatex) COMPILER="xelatex";;
    --ctan) CTAN=true;;
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

  if [ "$CTAN" = false ]; then
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
if [ "$CTAN" =  true ]; then
DIST=$DIST"-ctan"
mkdir -p "./build/ugentdocs"
fi

if [ "$CTAN" =  false ]; then
mkdir -p "./build/ugentdocs/ugentdocs" "./build/ugentdocs/examples"
mv "$TMP"/*.cls    "./build/ugentdocs/ugentdocs" 2>/dev/null || true
mv "$TMP"/*.sty    "./build/ugentdocs/ugentdocs/" 2>/dev/null || true
mv "$TMP"/*.dict   "./build/ugentdocs/ugentdocs/" 2>/dev/null || true
mv "$TMP"/*.clo    "./build/ugentdocs/ugentdocs/" 2>/dev/null || true
fi
generate_changelog "./build/ugentdocs/CHANGELOG.md"

if [ "$CTAN" = false ]; then
mv "$TMP"/Images/  "./build/ugentdocs/ugentdocs/" 2>/dev/null || true
else
mv "$TMP"/Images/  "./build/ugentdocs/" 2>/dev/null || true
fi

mv "$TMP/ugentdocs.pdf" "./build/ugentdocs/" 2>/dev/null || true

if [ "$CTAN" =  true ]; then
mv "$TMP/ugentdocs.dtx" "./build/ugentdocs/" 2>/dev/null || true
mv "$TMP/ugentdocs.ins" "./build/ugentdocs/" 2>/dev/null || true
generate_ctanreadme "./build/ugentdocs/README.md"
fi

for f in "$TMP"/*.pdf; do
  [ -f "$f" ] || continue
  mv "$f" "./build/ugentdocs/examples/"
done

if [ "$CTAN" =  false ]; then
for f in "$TMP"/example-*.tex; do
  [ -f "$f" ] || continue
  mv "$f" "./build/ugentdocs/examples/"
done
mv "$TMP"/*.cfg "./build/ugentdocs/examples/" 2>/dev/null || true

if [ "$IMG" = true ]; then
  mkdir -p "./build/ugentdocs/examples/images"
  for f in "./build/ugentdocs/examples/"*.pdf; do
      [ -f "$f" ] || continue
      base="$(basename "$f" .pdf)"
      pdftoppm -png -r 300 "$f" "./build/ugentdocs/examples/images/${base}"
  done
fi
fi

# 3.3 Remove tmp dir
rm -rf "$TMP"

# 4.0 Build zip for release attach
cd ./build
 zip -r "${DIST}.zip" "ugentdocs"
cd "$ROOT"

echo "Built ./build/${DIST}.zip"
