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
  lualatex -interaction=nonstopmode -halt-on-error ugentdocs.dtx
  lualatex -interaction=nonstopmode -halt-on-error ugentdocs.dtx

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
