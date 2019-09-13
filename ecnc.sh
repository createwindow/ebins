#!/bin/bash

if [ "$1" = "-a" -o $# = 2 ]; then
  ffplay http://ws-pull-live-enc.starmakerstudios.com/live_agora/$1_$2.flv
  echo "ffplay http://ws-pull-live-enc.starmakerstudios.com/live_agora/$1_$2.flv"
elif  [ "$1" = "-z" ]; then
  ffplay http://ws-pull-live-enc.starmakerstudios.com/live_zego/$1_$2.flv
  echo "ffplay http://ws-pull-live-enc.starmakerstudios.com/live_zego/$1_$2.flv"
elif  [ "$1" = "-zh" ]; then
  ffplay http://ws-pull-live-enc.starmakerstudios.com/live_zegohybrid/$1_$2.flv
  echo "ffplay http://ws-pull-live-enc.starmakerstudios.com/live_zegohybrid/$1_$2.flv"
else
  echo "Invalid arguments!"
  exit
fi

