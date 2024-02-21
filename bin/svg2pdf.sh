#!/bin/bash

# convert svg to pdf using inkscape in figures directory

cd /workdir

find ./ -name "*.svg" -print0 | while IFS= read -r -d '' file; do
    inkscape --export-area-drawing --export-text-to-path "$file" --export-filename="${file%.*}.pdf"
done