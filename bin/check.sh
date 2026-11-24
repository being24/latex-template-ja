#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <file without .tex extension>" >&2
    exit 2
fi

OUTDIR="$PWD/build-check"
NAME=$(basename "$1")
mkdir -p "$OUTDIR" || exit 2
rm -f "$OUTDIR/reference-check.status" "$OUTDIR/reference-check.txt"
# A missing result is an execution/build failure, not a clean reference check.
command -v checkcites >/dev/null || exit 2

# -usepretex は .latexmkrc のエンジン設定を latex に置き換えてしまうため、%S だけを %P に差し替える
latexmk -outdir="$OUTDIR" \
    -e '$pre_tex_code=q(\AddToHook{begindocument/before}{\RequirePackage[norefs,nocites,ignoreunlbld]{refcheck}})' \
    -e 'for ($latex, $pdflatex, $lualatex) { s/%S/%P/ }' \
    "$1.tex" || exit 2

status=0
report="$OUTDIR/reference-check.txt"
# Preserve checkcites output for both the local command and the nightly report.
checkcites --crossrefs --backend biber "$OUTDIR/$NAME" > "$report" 2>&1 || status=$?
cat "$report"
if [ "$status" -gt 1 ]; then
    exit 2
fi
# Reference warnings can wrap onto the next line. Include duplicate labels and citations.
if [ ! -f "$OUTDIR/$NAME.log" ]; then
    exit 2
fi
grep_status=0
grep -E -A 1 "Package refcheck Warning|LaTeX Warning: (Reference|Citation|Label .*multiply defined|There were (undefined references|multiply-defined labels))|Package biblatex Warning:.*(undefined|not found)" "$OUTDIR/$NAME.log" >> "$report" || grep_status=$?
if [ "$grep_status" -gt 1 ]; then
    exit 2
elif [ "$grep_status" -eq 0 ]; then
    status=1
fi
if [ "$status" -eq 0 ]; then
    printf 'clean\n' > "$OUTDIR/reference-check.status"
else
    printf 'findings\n' > "$OUTDIR/reference-check.status"
fi
exit "$status"
