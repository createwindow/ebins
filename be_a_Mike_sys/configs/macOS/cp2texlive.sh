#!/bin/bash

dst_dir="/usr/local/texlive/texmf-local/tex/latex/local/"

cp elegantnote_A3.cls "$dst_dir"
cp art_template_cn.cls "$dst_dir"
cp ppt_template_cn.cls "$dst_dir"

texhash
