#!/bin/bash

#set -x

RESULT_FILE="excluding_files"
RESULT_FILE_DIR="/tmp"
DEF_EXCLUDE=".svn"

usage()
{
    echo ""
    echo "Usage: $0 <SRC> <DEST> [EXCLUDE]"
}

if [ -n "$1" ]; then
    SRC=`echo $1`
else
    exit 1
    usage
fi

if [ -n "$2" ]; then
    DEST=`echo $2`
else
    exit 1
    usage
fi

if [ -n "$3" ]; then
    EXCLUDE=`echo $3`
else
    EXCLUDE=$DEF_EXCLUDE
fi


if [ -n "$SRC" ]; then
    cd $SRC
    SRC=`pwd`
    cd -
    cp -r `find $SRC -type d  -path "*/"$EXCLUDE  -prune -o -print` $DEST
else
    usage
    exit 1
fi

