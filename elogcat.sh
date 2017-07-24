#!/bin/bash

DST_DIR="$HOME/Downloads/vmshared/logcat"
TIME_STAMP=`date +"%Y%m%d_%H%M%S"`
FILE=logcat_$TIME_STAMP.txt

if [ ! -d "$DST_DIR" ]; then
    mkdir -p $DST_DIR
fi

usage()
{
    echo ""
    echo "Usage: $0 [-c] [dst]"
    echo "  save logcat messages to $DST_DIR/$FILE by default."
}

adb devices
if [ "$1" == "-c" ]; then
    adb logcat $1
elif [ -d "$1" ]; then 
    DST_DIR="$1"
fi

if [ "$2" != "" ]; then
    DST_DIR="$2"
fi
echo "saving to $DST_DIR/$FILE..."

adb logcat -vtime > $DST_DIR/$FILE

