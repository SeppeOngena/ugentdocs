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
    echo "The original source was substantially modified and expanded"
    echo "for the UGent house style. The major changes include:"
    echo
    echo "- Restructuring and merging of substantial portions of the code."
    echo "- Renaming and restructuring of classes."
    echo "- Reworking of dictionary handling. Including empty lines, newline placeholders, "
    echo "     casing typesetting of the keys, improving compatibility with babel"
    echo "- Reworking of logo input and handling. No images are used, only tikz paths and text."
    echo "- Reworking of book-cover generation. A separate ugentbookcover class is added which"
    echo "     prints the covers based on commands inputs instead of relying on PDF inputs."
    echo "- Integration of UGent-specific cover, chapter, and header/footer code."
    echo "- UGent-specific class functionality."
    echo "- Extensive changes to documentation and examples."
    echo
    echo "The detailed development history below is generated from Git."
    echo
    echo "## Development history"
    echo

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
VERSION="dev"

for arg in "$@"; do
  case "$arg" in
    --test) TEST=true ;;
    *) VERSION="$arg" ;;
  esac
done

ROOT="$(pwd)"
TMP="./build/_tmp"

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
lualatex -interaction=nonstopmode -halt-on-error ugentdocs.ins

if [ "$TEST" = false ]; then
  # 2.2 Build the documentation
  lualatex -interaction=nonstopmode -halt-on-error "\def\ugentdocsversion{$VERSION}\input{ugentdocs.dtx}"
  lualatex -interaction=nonstopmode -halt-on-error "\def\ugentdocsversion{$VERSION}\input{ugentdocs.dtx}"

  # 2.3 Build every example .tex file
  declare -A built
  while true; do # "dynamic" to support dissertation covers
    found_new=false
    for f in *.tex; do
      [ -f "$f" ] || continue
      [ -n "${built[$f]:-}" ] && continue
      lualatex -interaction=nonstopmode -halt-on-error "$f"
      lualatex -interaction=nonstopmode -halt-on-error "$f"
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
  mv "$TMP"/*  ./build/ 2>/dev/null || true
  rm -rf "$TMP"
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


# 4.0 Build zip for release attach
cd ./build
zip -r "${DIST}.zip" "${DIST}"
cd "$ROOT"

echo "Built ./build/${DIST}.zip"
