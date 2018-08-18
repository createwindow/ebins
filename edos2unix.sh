#!/bin/bash

# set -x

function read_convert() {
  for file in `ls $1`
  do
    file_path="$1/$file"
    if [ -d "$file_path" ]; then
      read_convert "$file_path"
    else
      # echo "Converting $file_path"
      dos2unix $file_path
    fi
  done
}

read_convert $1

exit 0

