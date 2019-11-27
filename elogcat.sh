#!/bin/bash

# DST_DIR="$HOME/Downloads/vmshared/logcat"
DST_DIR="$HOME/workspace/sublime_proj/logcat"
TIME_STAMP=`date +"%Y%m%d_%H%M%S"`
FILE=logcat_$TIME_STAMP.log
FILE_DEF=log.txt

if [ ! -d "$DST_DIR" ]; then
    mkdir -p $DST_DIR
fi

usage()
{
    echo ""
    echo "Usage: $0 [-c | -d] [dst]"
    echo "  save logcat messages to $DST_DIR/$FILE by default."
    echo "  -d, just save to $DST_DIR/xxx.txt"
}

adb devices
if [ "$1" == "-d" ]; then
    echo "saving to $DST_DIR/$FILE_DEF ..."
    adb logcat -c
    adb logcat -vtime > $DST_DIR/$FILE_DEF
else 
    if [ "$1" == "-c" ]; then
        adb logcat $1
    elif [ -d "$1" ]; then 
        DST_DIR="$1"
    fi

    if [ "$2" != "" ]; then
        DST_DIR="$2"
    fi
    echo "saving to $DST_DIR/$FILE ..."

    adb logcat -v threadtime > $DST_DIR/$FILE
fi

