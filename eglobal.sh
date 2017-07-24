#!/bin/sh
# etags.sh: this uitility is used to generated tag files, which are used by 
# global and ctag.

#set -x

DEST_DIR=`pwd`
RESULT_FILE="gtags.files"
SYMBOLIC_LINK_DIR="platform"

usage()
{
    echo ""
    echo "Usage: $0 [DEST]"
    echo "DEST: current directory if not set."
}

if [ -n "$1" ]; then
    DEST_DIR=`echo $1 | tr -d \/`
fi

if [ -d "$DEST_DIR" ]; then
    cd $DEST_DIR
    DEST_DIR=`pwd`
    # -H: Do not follow symbolic links, except while processing the command line 
    #     arguments.
    # -L: Follow symbolic links.
    find -L .                              \
        \( -path "*/.svn" -o               \
        -path ./installedToolchain -o      \
        -path ./LOGDIR -o                  \
        -path ./release-v20  -o            \
        -path ./WRL -o                     \
        -path ./toolchain -o               \
        -path ./wrl3.GA -o                 \
        -path ./wrlinux_toolchain -o       \
        -path ./wrll-pel-bcm \) -prune -o  \
        -name "*.[chsS]" -print -o         \
        -name "*.cpp" -print -o            \
        -name "*.mm" -print -o             \
        -name "*.m" -print -o             \
        -name "*.cxx" -print -o            \
        -name "*.hxx" -print -o            \
        -name "*.cc" -print -o             \
        -name "*.hh" -print -o             \
        -name "*.java" -print -o           \
        -name "*.sh" -print > "$DEST_DIR/$RESULT_FILE" #MUST be an absolute path
    gtags
    ctags -L $RESULT_FILE --fields=+lS #handled by indexer.tar.gz
    echo "Tag files for $DEST_DIR ready!"
else
    echo "$DEST_DIR NOT exist!"
    usage
fi

