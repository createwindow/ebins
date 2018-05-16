#!/bin/bash

if [ -f "$1" ]; then
    file_name="$1"
    file_name=${file_name%%.*}
    echo "$file_name"
    rm $file_name.eps
else
    echo "File $1 not exist."
fi

# not rotate resulting EPS
ps2eps -R=- "$1"

