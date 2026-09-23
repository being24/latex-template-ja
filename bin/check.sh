#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <file without .tex extension>" >&2
    exit 2
fi

OUTDIR="$PWD/build-check"
NAME=$(basename "$1")

# -usepretex は .latexmkrc のエンジン設定を latex に置き換えてしまうため、%S だけを %P に差し替える
latexmk -outdir="$OUTDIR" \
    -e '$pre_tex_code=q(\AddToHook{begindocument/before}{\RequirePackage[norefs,nocites,ignoreunlbld]{refcheck}})' \
    -e 'for ($latex, $pdflatex, $lualatex) { s/%S/%P/ }' \
    "$1.tex" || exit 1

status=0
checkcites --crossrefs --backend biber "$OUTDIR/$NAME" || status=1
# Reference 警告は 79 桁で折り返され undefined が次行に回ることがあるため前半だけで照合する
if grep -E "Package refcheck Warning|LaTeX Warning: Reference" "$OUTDIR/$NAME.log"; then
    status=1
fi
exit $status
