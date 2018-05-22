#!/bin/bash

# set -x

# sdk_so="libjingle_peerconnection_so.so"
# sdk_jar="libjingle_peerconnection_java.jar"
sdk_so="libzorro.so"
sdk_jar="libzorro.jar"

webrtc_51_home="/Volumes/espace/shared_vagrant/rtc_android_51/src"
webrtc_home="$webrtc_51_home"

dir_out_rls="$webrtc_home/out/Release"
dir_out_dbg="$webrtc_home/out/Debug"
dir_so_in_webrtc_unstripped="lib"
dir_so_in_webrtc_stripped="lib/stripped"
dir_jar_in_webrtc="lib.java"

usage()
{
    echo ""
    echo "Usage: $0 [OPTION]"
    echo "OPTION: -t, for test app (default option);"
    echo "        -p, for product app."
    echo "        -s, using the stripped library."
    echo "        -d, for debug (default option)."
    echo "        -r, for release."
    echo "        -h, for help."
}

while getopts "tpsdr" option
do
    case $option in
        h)  usage
            exit 
        ;;
        t)  if [ "$for_app" = "p" ]; then
                echo "Invalid option: t"
                usage
                exit
            else
                for_app="t"
            fi
        ;;
        p)  if [ "$for_app" = "t" ]; then
                echo "Invalid option: p"
                usage
                exit
            else
                for_app="p"
            fi
        ;;
        d)  if [ "$build" = "r" ]; then
                echo "Invalid option: d"
                usage
                exit
            else
                build="d"
            fi
        ;;
        r)  if [ "$build" = "d" ]; then
                echo "Invalid option: r"
                usage
                exit
            else
                build="r"
            fi
        ;;
        s)  strip="true"
        ;;
        ?)  usage
            exit 1
        ;;
    esac
done

if [ "$for_app" = "" ]; then
    for_app="t"
fi

if [ "$build" = "" ]; then
    build="d"
fi

if [ "$strip" = "" ]; then
    strip="false"
fi

echo "for_app=$for_app build=$build strip=$strip"

if [ $for_app = "r" ]; then
    dir_out=$dir_out_rls 
else
    dir_out=$dir_out_dbg
fi

src_jar="$dir_out/$dir_jar_in_webrtc/$sdk_jar"

if [ "$strip" = "true" ]; then
  src_so="$dir_out/$dir_so_in_webrtc_stripped/$sdk_so"
else
  src_so="$dir_out/$dir_so_in_webrtc_unstripped/$sdk_so"
fi

# ================== TEST APP ===================
client_test_app="$HOME/mywork/ushow/rtc_android_client"
dir_so_in_test_app="app/src/main/libs/armeabi-v7a"
dir_jar_in_test_app="app/libs"
# ================== TEST APP ===================

if [ $for_app = "t" ]; then
    dst_so="$client_test_app/$dir_so_in_test_app"
    dst_jar="$client_test_app/$dir_jar_in_test_app"

    echo "$src_so ---> $dst_so ..."
    cp    $src_so      $dst_so 

    echo "$src_jar ---> $dst_jar ..."
    cp    $src_jar      $dst_jar
fi

