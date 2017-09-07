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
    find -L .                                                                   \
        \(                                                                      \
        -path "*/.svn" -o                                                       \
        -path "*/.git" -o                                                       \
        -path "./chromium/src/android_webview" -o                               \
        -path "./chromium/src/apps" -o                                          \
        -path "./chromium/src/ash" -o                                           \
        -path "./chromium/src/blimp" -o                                         \
        -path "./chromium/src/blink" -o                                         \
        -path "./chromium/src/build_overrides" -o                               \
        -path "./chromium/src/buildtools" -o                                    \
        -path "./chromium/src/cc" -o                                            \
        -path "./chromium/src/chrome" -o                                        \
        -path "./chromium/src/chromecast" -o                                    \
        -path "./chromium/src/chrome_elf" -o                                    \
        -path "./chromium/src/chromeos" -o                                      \
        -path "./chromium/src/components" -o                                    \
        -path "./chromium/src/content" -o                                       \
        -path "./chromium/src/courgette" -o                                     \
        -path "./chromium/src/dbus" -o                                          \
        -path "./chromium/src/device" -o                                        \
        -path "./chromium/src/docs" -o                                          \
        -path "./chromium/src/extensions" -o                                    \
        -path "./chromium/src/google_apis" -o                                   \
        -path "./chromium/src/google_update" -o                                 \
        -path "./chromium/src/gpu" -o                                           \
        -path "./chromium/src/headless" -o                                      \
        -path "./chromium/src/infra" -o                                         \
        -path "./chromium/src/ipc" -o                                           \
        -path "./chromium/src/jingle" -o                                        \
        -path "./chromium/src/mash" -o                                          \
        -path "./chromium/src/media" -o                                         \
        -path "./chromium/src/native_client_sdk" -o                             \
        -path "./chromium/src/pdf" -o                                           \
        -path "./chromium/src/ppapi" -o                                         \
        -path "./chromium/src/printing" -o                                      \
        -path "./chromium/src/remoting" -o                                      \
        -path "./chromium/src/rlz" -o                                           \
        -path "./chromium/src/sandbox" -o                                       \
        -path "./chromium/src/skia" -o                                          \
        -path "./chromium/src/storage" -o                                       \
        -path "./chromium/src/styleguide" -o                                    \
        -path "./chromium/src/sync" -o                                          \
        -path "./chromium/src/third_party/webrtc" -o                            \
        -path "./chromium/src/third_party/webrtc_overrides" -o                  \
        -path "./chromium/src/third_party/openh264" -o                          \
        -path "./chromium/src/third_party/ffmpeg" -o                            \
        -path "./chromium/src/third_party/mingw-w64" -o                         \
        -path "./chromium/src/third_party/skia" -o                              \
        -path "./chromium/src/third_party/blimp_fonts" -o                       \
        -path "./chromium/src/third_party/mesa" -o                              \
        -path "./chromium/src/third_party/sfntly" -o                            \
        -path "./chromium/src/third_party/webgl" -o                             \
        -path "./chromium/src/third_party/httpcomponents-client" -o             \
        -path "./chromium/src/third_party/llvm-build" -o                        \
        -path "./chromium/src/third_party/httpcomponents-core" -o               \
        -path "./chromium/src/third_party/deqp" -o                              \
        -path "./chromium/src/third_party/perl" -o                              \
        -path "./chromium/src/third_party/bison" -o                             \
        -path "./chromium/src/third_party/drmemory" -o                          \
        -path "./chromium/src/third_party/hunspell_dictionaries" -o             \
        -path "./chromium/src/third_party/cld_2" -o                             \
        -path "./chromium/src/third_party/libphonenumber" -o                    \
        -path "./chromium/src/third_party/blimp_fonts" -o                       \
        -path "./chromium/src/third_party/cygwin" -o                            \
        -path "./chromium/src/third_party/lighttpd" -o                          \
        -path "./chromium/src/third_party/nss" -o                               \
        -path "./chromium/src/third_party/kasko" -o                             \
        -path "./chromium/src/third_party/angle" -o                             \
        -path "./chromium/src/third_party/leakcanary" -o                        \
        -path "./chromium/src/third_party/chromite" -o                          \
        -path "./chromium/src/ui" -o                                            \
        -path "./chromium/src/win8" -o                                          \
        -path "./out"                                                           \
        \) -prune -o                                                            \
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
    gtags -f $RESULT_FILE
    ctags -L $RESULT_FILE --fields=+lS #handled by indexer.tar.gz
    end_time=`date +%s`
    used_time=$(($end_time - $start_time))
    echo "Tag files for $DEST_DIR ready! Used $used_time seconds."
else
    echo "$DEST_DIR NOT exist!"
    usage
fi

