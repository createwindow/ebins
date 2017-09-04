#!/bin/sh
# etags.sh: this uitility is used to generated tag files, which are used by 
# global and ctag.

#set -x

DEST_DIR=`pwd`
RESULT_FILE="gtags.files"
SYMBOLIC_LINK_DIR="platform"

GLOBAL_FILES="gtags.files GTAGS GPATH GRTAGS"
CTAGS_FILES="tags"

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
    start_time=`date +%s`
    cd $DEST_DIR
    
    rm -f $GLOBAL_FILES $CTAGS_FILES

    DEST_DIR=`pwd`
    # -H: Do not follow symbolic links, except while processing the command line 
    #     arguments.
    # -L: Follow symbolic links.
    find -L .                                      \
        \(                                         \
        -path "*/.svn" -o                          \
        -path "*/.git" -o                          \
        -path ./chromium/src/third_party/webrtc -o \
        -path ./out                                \
        \) -prune -o                               \
        -name "*.[chsS]" -print -o  \
        -name "*.cpp" -print -o     \
        -name "*.mm" -print -o      \
        -name "*.m" -print -o       \
        -name "*.cxx" -print -o     \
        -name "*.hxx" -print -o     \
        -name "*.cc" -print -o      \
        -name "*.hh" -print -o      \
        -name "*.java" -print -o    \
        -name "*.sh" -print > "$DEST_DIR/$RESULT_FILE" #MUST be an absolute path
    gtags
    ctags -L $RESULT_FILE --fields=+lS #handled by indexer.tar.gz
    end_time=`date +%s`
    used_time=$(($end_time - $start_time))
    echo "Tag files for $DEST_DIR ready! Used $used_time seconds."
else
    echo "$DEST_DIR NOT exist!"
    usage
fi

