#!/bin/bash
# svn will invoke this with a bunch of arguments.  These are:
# $1 - path to the file that is the original
# $2 - path to the file that's the incoming merge version
# $3 - path to the file that's the latest from trunk (current working copy)
# $4 - path to where svn expects the merged output to be written
diffmerge --nosplash -m -t1="Incoming Merge Changes"  -t2="Original (merged)" -t3="Current Working Copy changes" -r="$4" "$2" "$1" "$3"

