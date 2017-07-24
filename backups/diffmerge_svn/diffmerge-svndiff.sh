#!/bin/bash
# svn will invoke this with a bunch of arguments.  These are:
# -u -L "<left-label>" -L "<right-label>" <left-file> <right-file>
diffmerge --nosplash -t1="$3"  -t2="$5" "$6" "$7"

