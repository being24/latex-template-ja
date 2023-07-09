#!/bin/bash

git config --global --add safe.directory /workdir
# 一つ前のコミットとこのコミットの差分
latexdiff-vc -e utf8 -t CFONT --git --flatten --force -r HEAD main.tex

# 現在と指定したIDの差分
# latexdiff-vc -e utf8 -t CFONT --git --flatten --force -r commit-ID main.tex

# 一つ前のタグと最新のタグの差分
# git tag | sort -V | tail -n 2 | xargs -n 2 bash -c 'latexdiff-vc -e utf8 -t CFONT --git --flatten --force -r $0 -r $1 -t CFONT main.tex'

# diffファイルへの出力
# git diff commit_id commit_id "*.tex"  > diff.diff
