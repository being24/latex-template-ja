#!/bin/bash

cd /workdir
FILES=$(find ./ -type f \( -name "*.tex" \) -not -name '__latexindent_temp.tex')
# FILES=$(find ./ -type f \( -name "*.tex" -o -name "*.bib" -o -name "*.cls" -o -name "*.sty" \) -not -name '__latexindent_temp.tex')
for file in $FILES;do
    tex-fmt $file
done
