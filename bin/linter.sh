#!/bin/bash

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# latexindent is only installed inside the latex-docker image. When run
# outside it (e.g. host-side, not the Dev Container), re-exec this script
# inside the container instead of failing.
if ! command -v latexindent >/dev/null 2>&1; then
    exec docker run --rm -u "$(id -u):$(id -g)" -v "$REPO_ROOT:/workdir" -w /workdir ghcr.io/being24/latex-docker bash /workdir/bin/linter.sh "$@"
fi

cd "$REPO_ROOT"
FILES=`find ./ -name "*.tex" -not -name '__latexindent_temp.tex'`
result=''
for file in $FILES;do
    result=$result$file' '
done
latexindent $result -c="$REPO_ROOT/backups" -l -m -w -s -r
