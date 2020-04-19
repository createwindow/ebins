#!/bin/bash

# set -x

# sdk_so="libjingle_peerconnection_so.so"
# sdk_jar="libjingle_peerconnection_java.jar"
sdk_so="libzorro.so"
sdk_jar="libzorro.jar"
# sdk_aar="zorro_sdk.aar"
sdk_aar="zorro-rtc-sdk.aar"

# webrtc_51_home="/Volumes/espace/shared_vagrant/rtc_android_51/src"
# webrtc_51_home="/Volumes/Samsung_T5/shared_vagrant/rtc_android_51/src"
# webrtc_home="$webrtc_51_home"
# webrtc_72_home="/Volumes/Samsung_T5/shared_vagrant/rtc_android_72/src"
webrtc_72_home="/Volumes/shared_vagrant/rtc_android_72/src"
webrtc_home="$webrtc_72_home"

dir_out_rls="$webrtc_home/out/Release"
dir_out_dbg="$webrtc_home/out/Debug"
dir_out_aar="$webrtc_home/out"
dir_so_in_webrtc_unstripped="lib"
dir_so_in_webrtc_stripped="lib/stripped"
dir_jar_in_webrtc="lib.java"
dir_aar_in_webrtc="zorro_aar"

usage()
{
    echo ""
    echo "Usage: $0 [OPTION]"
    echo "OPTION: -t, for test app (default option);"
    echo "        -p, for product app."
    echo "        -s, using the stripped library (default for release)."
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
                strip="true"
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

printf -- '\n\033[35mfor_app=%s build=%s strip=%s \033[0m \n\n' $for_app $build $strip;

if [ $build = "r" ]; then
    dir_out=$dir_out_rls 
else
    dir_out=$dir_out_dbg
fi

src_jar="$dir_out/$dir_jar_in_webrtc/$sdk_jar"
# src_aar="$dir_out/$dir_aar_in_webrtc/$sdk_aar"
src_aar="$webrtc_72_home/$sdk_aar"

if [ "$strip" = "true" ]; then
  src_so="$dir_out/$dir_so_in_webrtc_stripped/$sdk_so"
else
  src_so="$dir_out/$dir_so_in_webrtc_unstripped/$sdk_so"
fi

if [ $for_app = "t" ]; then
# ================== TEST APP ===================
# client_app="$HOME/mywork/ushow/rtc_android_client"
client_app="/Volumes/Samsung_T5/rtc_android_client"
dir_so_in_app="app/src/main/libs/armeabi-v7a"
dir_jar_in_app="app/libs"
dir_aar_in_app="app/libs"
# ================== TEST APP ===================
elif [ $for_app = "p" ]; then
# ================== StarMaker APP ===================
# client_app="/Volumes/Samsung_T5/starmaker-android-client"
client_app="$HOME/workspace/code/ushow/starmaker-android-client"
dir_so_in_app="libraries/mediacore/src/main/libs/armeabi-v7a"
dir_jar_in_app="libraries/mediacore/libs"
dir_aar_in_app="libraries/aars"
# ================== StarMaker APP ===================
fi


dst_so="$client_app/$dir_so_in_app"
dst_jar="$client_app/$dir_jar_in_app"
dst_aar="$client_app/$dir_aar_in_app"

# echo "$src_so ---> $dst_so ..."
# cp    $src_so      $dst_so 

# echo "$src_jar ---> $dst_jar ..."
# cp    $src_jar      $dst_jar

echo "$src_aar ---> $dst_aar ..."
cp    $src_aar      $dst_aar
