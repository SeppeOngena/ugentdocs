#!/bin/bash
set -x
rm -rf ./build
mkdir ./build
cp ugentdocs.dtx ugentdocs.ins ./build/
cp -a ./Images/. ./build/Images
cd ./build
lualatex ugentdocs.ins
