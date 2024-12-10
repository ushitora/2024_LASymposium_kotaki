#!/usr/bin/env perl

$pdf_mode = 3;
$latex = 'uplatex %O %S';
$dvipdf = 'dvipdfmx %O %S -o %D';
$bibtex = 'upbibtex %O %S';