#!/bin/bash
# set -x

# iconv -l # show all coded character sets
from="LATIN1"
to="UTF-8"

function read_convert() {
  for file in `ls $1`
  do
    file_path="$1/$file"
    if [ -d "$file_path" ]; then
      read_convert "$file_path"
    else
      # echo "Converting $file_path"
      iconv -s -f $from -t $to "$file_path" > "$file_path".tmp
      cp "$file_path".tmp "$file_path"
      rm "$file_path".tmp
    fi
  done
}

read_convert $1

exit 0

