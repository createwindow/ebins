#!/bin/bash

#set -x

DIR_REM_RLS_OUT="root@118.244.252.45:/root"


usage()
{
    echo ""
    echo "Usage: $0 [file]"
}

if [ -n "$1" ]; then
    FILE="$DIR_REM_RLS_OUT/$1"
else 
    usage
    exit 1
fi

echo $FILE

rcp "$FILE" .

