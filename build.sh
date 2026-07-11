#!/bin/bash
set -x
rm -rf ./build
mkdir ./build
cp ugentdocs.dtx ugentdocs.ins ./build/
cd ./build
lualatex ugentdocs.ins
