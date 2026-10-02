#!/bin/bash
# Extracts images from the example files
set -euxo pipefail

mkdir -p "./build/images"
for f in "./build/examples/"*.pdf; do
  [ -f "$f" ] || continue
  base="$(basename "$f" .pdf)"
  pdftoppm -png -r 300 "$f" "./build/images/${base}"
done
