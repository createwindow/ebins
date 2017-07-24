#!/bin/bash
# svn will invoke this with a bunch of arguments. These are: 
# -E -m -L "<working-label>" -L "<left-label>" -L "<right-label>" "working-file" "left-file" "right-file"
diffmerge --nosplash -t1="$4" -t2="$6" -t3="$8" "$9" "$10" "$11"

