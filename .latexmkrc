#!/usr/bin/env perl

$latex = 'uplatex  -synctex=1 -halt-on-error --shell-escape %S';
$latex_silent = 'uplatex  -synctex=1 -halt-on-error -interaction=batchmode';
$bibtex = 'upbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars';

$pdf_mode = 3;
$max_repeat = 10;
