#!/bin/bash

# convert svg to pdf using inkscape in figures directory

cd /workdir
FILES=`find ./ -name "*.svg"`

for file in $FILES;do
    inkscape --export-area-drawing --export-text-to-path $file --export-filename=${file%.*}.pdf
done