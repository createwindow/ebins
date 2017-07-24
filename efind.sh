#!/bin/bash

#set -x

usage()
{
    echo "None-case-sensitive find."
    echo "Usage: $0 <expression> [path]"
}

path="."
if [ "$2" != "" ]; then
    if [ -d "$2" ]; then
        path="$2"
    else
        echo "$2 NOT exist!"
    fi
fi

if [ "$1" != "" ]; then
    find "$path" -iname "$1"
else
    usage
fi

