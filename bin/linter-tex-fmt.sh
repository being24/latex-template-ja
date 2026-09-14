#!/bin/bash

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# tex-fmt is only installed inside the latex-docker image. When run outside
# it (e.g. host-side, not the Dev Container), re-exec this script inside the
# container instead of failing.
if ! command -v tex-fmt >/dev/null 2>&1; then
    exec docker run --rm -u "$(id -u):$(id -g)" -v "$REPO_ROOT:/workdir" -w /workdir ghcr.io/being24/latex-docker bash /workdir/bin/linter-tex-fmt.sh "$@"
fi

cd "$REPO_ROOT"
FILES=$(find ./ -type f \( -name "*.tex" \) -not -name '__latexindent_temp.tex')
# FILES=$(find ./ -type f \( -name "*.tex" -o -name "*.bib" -o -name "*.cls" -o -name "*.sty" \) -not -name '__latexindent_temp.tex')
for file in $FILES;do
    tex-fmt $file
done
