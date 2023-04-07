#!/usr/bin/env perl

$latex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error -halt-on-error --shell-escape %S';
$bibtex = 'upbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars';

$pdf_mode = 3;
$max_repeat = 10;
