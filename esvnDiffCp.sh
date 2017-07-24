#!/bin/bash
#set -x

DST_DIR_DEF=`pwd`
SVN_STATUS_FILE="svn_status_tmp.txt"
ST_FILE_DIR="svnDiffFiles"
LOG_FILE="read.txt"
 

cd $DST_DIR_DEF
if [ ! -d "$ST_FILE_DIR" ]; then
    mkdir $ST_FILE_DIR
fi

svn status > $SVN_STATUS_FILE
while read line 
do 
    file=`echo $line | awk '$1 == "M" {print $2}'`
    if [ -n "$file" ]; then
        echo $file >> $LOG_FILE
        if [ -f "$file" ];then
            cp $file ./$ST_FILE_DIR
        fi
    fi
    file=`echo $line | awk '$1 == "?" {print $2}'`
    if [ -n "$file" ]; then
        echo $file >> $LOG_FILE
        if [ -f "$file" ];then
            cp $file ./$ST_FILE_DIR
        fi
    fi
done < $SVN_STATUS_FILE

mv $LOG_FILE $DST_DIR_DEF/$ST_FILE_DIR
rm -f $SVN_STATUS_FILE

