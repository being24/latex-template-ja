#!/bin/bash

# convert svg to pdf using inkscape in figures directory

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# inkscape is only installed inside the latex-docker image. When run outside
# it (e.g. host-side, not the Dev Container), re-exec this script inside the
# container instead of failing.
if ! command -v inkscape >/dev/null 2>&1; then
    exec docker run --rm -u "$(id -u):$(id -g)" -v "$REPO_ROOT:/workdir" -w /workdir ghcr.io/being24/latex-docker bash /workdir/bin/svg2pdf.sh "$@"
fi

cd "$REPO_ROOT"

# find ./ -name "*.svg" -print0 | while IFS= read -r -d $'\0' file; do
#     new_file="${file// /_}"
#     inkscape --export-area-drawing --export-text-to-path "$file" --export-filename="${new_file%.*}.pdf"
# done

# find ./ -name "*.svg" -print0 | xargs -0 -I {} echo "{}"

find ./ -name "*.svg" -print0 | xargs -0 -I {} bash -c '
    echo "Processing file: {}"
    file="{}"
    new_file="${file// /_}"
    inkscape --export-area-drawing --export-text-to-path "$file" --export-filename="${new_file%.*}.pdf"
'
