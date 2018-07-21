#!/bin/bash

if [ -f "$1" ]; then
    file_name="$1"
    file_name=${file_name%%.*}
    convert "$1" $file_name.eps
    echo "convert $1 to $file_name.eps"
else
    echo "File $1 not exist."
fi

