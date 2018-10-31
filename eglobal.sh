#!/bin/sh
# etags.sh: this uitility is used to generated tag files, which are used by 
# global and ctag.

#set -x

DEST_DIR=`pwd`
RESULT_FILE="gtags.files"

GLOBAL_FILES="gtags.files GTAGS GPATH GRTAGS"
CTAGS_FILES="tags"

usage()
{
    echo ""
    echo "Usage: $0 [EXLUSION]"
    echo "  EXLUSION: 51/71"
}

if [ "$1" = "-h" -o "$1" = "" ]; then
    usage
    exit
# elif [ -n "$1" ]; then
    # DEST_DIR=`echo $1 | tr -d \/`
fi

excluded_dirs_webrtc_android_51='
  -E chromium
  -E out
  -E tools
'
excluded_dirs_webrtc_android_51_l1='
  -E chromium
  -E out
  -E tools
  -E '/build'
  -E third_party/WebKit
  -E third_party/abseil-cpp
  -E third_party/adobe
  -E third_party/android_async_task
  -E third_party/android_crazy_linker
  -E third_party/android_data_chart
  -E third_party/android_deps
  -E third_party/android_media
  -E third_party/android_ndk
  -E third_party/android_opengl
  -E third_party/android_platform
  -E third_party/android_protobuf
  -E third_party/android_sdk
  -E third_party/android_support_test_runner
  -E third_party/android_swipe_refresh
  -E third_party/android_system_sdk
  -E third_party/android_tools
  -E third_party/apache-portable-runtime
  -E third_party/apache-win32
  -E third_party/apk-patch-size-estimator
  -E third_party/apple_apsl
  -E third_party/apple_sample_code
  -E third_party/appurify-python
  -E third_party/arcore-android-sdk
  -E third_party/ashmem
  -E third_party/blink
  -E third_party/libc++-static
  -E third_party/llvm-build
  -E third_party/tcmalloc
  -E '*_unittest*'
  -E test
'

excluded_dirs_webrtc_android_71_l1='
  -E '/build'
  -E '/build_overrides'
  -E '/buildtools'
  -E data 
  -E infra
  -E out
  -E resources
  -E style-guide
  -E rtc_tools
  -E tools
  -E tools_webrtc
  -E third_party/Python-Markdown
  -E third_party/SPIRV-Tools
  -E third_party/accessibility-audit
  -E third_party/accessibility_test_framework
  -E third_party/WebKit
  -E third_party/abseil-cpp
  -E third_party/adobe
  -E third_party/android_build_tools
  -E third_party/android_crazy_linker
  -E third_party/android_data_chart
  -E third_party/android_deps
  -E third_party/android_media
  -E third_party/android_ndk
  -E third_party/android_opengl
  -E third_party/android_platform
  -E third_party/android_protobuf
  -E third_party/android_sdk
  -E third_party/android_support_test_runner
  -E third_party/android_swipe_refresh
  -E third_party/android_system_sdk
  -E third_party/android_tools
  -E third_party/apache-portable-runtime
  -E third_party/apache-win32
  -E third_party/apk-patch-size-estimator
  -E third_party/apple_apsl
  -E third_party/arcore-android-sdk
  -E third_party/ashmem
  -E third_party/blink
  -E third_party/llvm-build
  -E third_party/tcmalloc
  -E third_party/test_fonts
  -E third_party/web-animations-js
  -E third_party/webdriver
  -E third_party/webgl
  -E third_party/win_build_output
'
  # -E examples
  # -E test
  # -E testing
  # -E '*_unittest*'

# excluded_dirs=$excluded_dirs_webrtc_android_51
if [ "$1" = "51" ]; then
  excluded_dirs=$excluded_dirs_webrtc_android_51_l1
elif [ "$1" = "71" ]; then
  excluded_dirs=$excluded_dirs_webrtc_android_71_l1
else
  usage
  exit
fi

if [ -d "$DEST_DIR" ]; then
    start_time=`date +%s`
    cd $DEST_DIR
    
    rm -f $GLOBAL_FILES $CTAGS_FILES $RESULT_FILE

    DEST_DIR=`pwd`
    # fd does NOT include hidden files and directories in the search results by default.
    # -L: Follow symbolic links.
    # -I: Do not respect files like .gitignore and .fdignore and include ignored files 
    #     in the search results.
    # XXX: Do NOT quote @excluded_dirs
    fd -I -L                 \
       $excluded_dirs        \
       -e "c"    -e "h"      \
       -e "cc"   -e "hh"     \
       -e "cpp"  -e "hpp"    \
       -e "cxx"  -e "hxx"    \
       -e "java"             \
       -e "m"    -e "mm"     \
       -e "sh"               \
       -e "s"    -e "S"      \
    > "$DEST_DIR/$RESULT_FILE" # MUST be an absolute path
    gtags -f $RESULT_FILE
    ctags -L $RESULT_FILE --fields=+liaS #handled by indexer.tar.gz

    end_time=`date +%s`
    used_time=$(($end_time - $start_time))
    # 37 normal 32 success 33 warning 31 error
    printf -- '\033[32m  Tag files for %s ready! Used %s seconds. \033[0m\n' $DEST_DIR $used_time;
    
else
    echo "$DEST_DIR NOT exist!"
    usage
    exit
fi

