#!/bin/bash

file_name=`basename "$1"`
dir=`dirname "$1"`

# echo "$file_name $dir"

start_time=`date +%s`
ffmpeg -i "$1" -vf scale=1280x720 "$dir"/"$file_name"1.mp4
end_time=`date +%s`

used_time=$(($end_time - $start_time))
printf -- '\033[32m\nConerting in $dir, used \033[0m\n'  $used_time;

