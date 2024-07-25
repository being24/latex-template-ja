#!/bin/bash

# convert svg to pdf using inkscape in figures directory

cd /workdir

# find ./ -name "*.svg" -print0 | while IFS= read -r -d $'\0' file; do
#     new_file="${file// /_}"
#     inkscape --export-area-drawing --export-text-to-path "$file" --export-filename="${new_file%.*}.pdf"
# done

# find ./ -name "*.svg" -print0 | xargs -0 -I {} echo "{}"

find ./ -name "*.svg" -print0 | xargs -0 -I {} bash -c '
    file="{}"
    new_file="${file// /_}"
    inkscape --export-area-drawing --export-text-to-path "$file" --export-filename="${new_file%.*}.pdf"
'