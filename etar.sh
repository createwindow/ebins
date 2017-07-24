#!/bin/bash
# Enhanced tar: filter a directory archive <DIR> with gzip, then move it to
# <DEST>. This utility intends to share directories between Virtual machines
# and the host.

#set -x

DEF_DEST="$HOME/Downloads/vmshared"

usage()
{
    echo ""
    echo "Usage: $0 <DIR> [DEST]"
    echo "DEST: $DEF_DEST if not set"
}

if [ -d "$1" -o -f "$1" ]; then
    extension=".tar.gz"
    basename=`echo $1 | tr -d \/` #delete the ending '/' of $1
    tarball=$basename$extension
    dst_dir=$DEF_DEST
    if [ -n "$2" ]; then
        dst_dir=$2
    fi

    if [ -d "$dst_dir" ]; then
        rm -f $tarball
        echo "Creating $tarball for $1..."
        tar czf $tarball $1

        if [ "$dst_dir" != "." ]; then
            rm -f $dst_dir/$tarball
            echo "Sending $tarball to $dst_dir"
            #"$dst_dir" MUST have quotes, or the name with spaces are NOT valid.
            mv $tarball "$dst_dir" 
        fi
    else
        echo "$dst_dir NOT exist!"
        usage
    fi
else
    echo "$1 NOT exist!"
    usage
fi

