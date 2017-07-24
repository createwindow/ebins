#!/bin/bash

#set -x

RESULT_FILE="excluding_files"
RESULT_FILE_DIR="/tmp"
DEF_EXCLUDE_LIST=".svn *.swp *~"

usage()
{
    echo ""
    echo "Usage: $0 <SRC> <DEST> [EXCLUDE]"
    echo "<DEST> could be .?, but <SRC> must end with /"
    echo "<SRC> & <DEST> are usually the same."
}

if [ -n "$1" ]; then
    SRC_DIR=`echo $1`
else
    usage
    exit 1
fi

if [ -n "$2" ]; then
    DEST_DIR=`echo $2`
    cd $DEST_DIR
    DEST_DIR=`pwd`
    cd -
else
    usage
    exit 1
fi

if [ -n "$3" ]; then
    EXCLUDE=`echo $3`
else
    EXCLUDE=$DEF_EXCLUDE
fi


if [ -n "$SRC_DIR" ]; then
    cd $SRC_DIR
    #[PATH] for find must be ".", othwiase, the directory path is absolute. 
    for FILE_NAME in $DEF_EXCLUDE_LIST
    do
        find . -name "$FILE_NAME" | sed 's/\.\///g' >> $RESULT_FILE_DIR/$RESULT_FILE 
    done 
else
    usage
    exit 1
fi

echo "Excluding files (WARNING-only overwrite and copy files to @DEST, @SRC & @DEST may be different):"
cat $RESULT_FILE_DIR/$RESULT_FILE
echo ""
cd - 
DEST_DIR= pwd | sed -e "s#^#.#" -e "s#/[^/]*#/..#g" -e "s#\$#$DEST_DIR#"
echo $DEST_DIR

rsync -av --exclude-from=$RESULT_FILE_DIR/$RESULT_FILE $SRC_DIR $DEST_DIR
rm -f $RESULT_FILE_DIR/$RESULT_FILE

