#!/bin/bash

set -x

if [ -f "$1" ]; then
    file_name="$1"
    file_name=${file_name%%.*}
    echo "$file_name"
    rm -f $file_name.eps
else
    echo "File $1 not exist."
fi

if [ "$2" = "-r" ]; then
    revert="-R=-"
else
    echo "Inavlid argument: $2"
fi

# not rotate resulting EPS
# ps2eps -R=- "$1"
if [ "$revert" != "" ]; then
  ps2eps "$revert" "$1"
else
  ps2eps "$1"
fi

