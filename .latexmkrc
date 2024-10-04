#!/usr/bin/env perl

$do_cd = 1;

# $latex = 'platex -synctex=1 -interaction=nonstopmode -file-line-error -halt-on-error %O %S';
$latex = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error -halt-on-error %O %S';
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error -halt-on-error --shell-escape %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'makeindex %O -o %D %S';

$bibtex_use=2;
$bibtex = 'upbibtex %O %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %O %S';

$clean_ext="$clean_ext run.xml";

# uplatexは3,lualatexは4
$pdf_mode = 3;
$max_repeat = 10;
