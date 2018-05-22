#!/bin/bash

#set -x
sdk_so="libjingle_peerconnection_so.so"
sdk_jar="libjingle_peerconnection_java.jar"

webrtc_51_home="/Volumes/espace/shared_vagrant/rtc_android_51/src"
webrtc_home="$webrtc_51_home"

dir_out_rls="$webrtc_home/out/Release"
dir_out_dbg="$webrtc_home/out/Debug"
dir_so_in_webrtc="lib"
dir_jar_in_webrtc="lib.java"

src_so="$dir_out_dbg/$dir_so_in_webrtc/$sdk_so"
src_jar="$dir_out_dbg/$dir_jar_in_webrtc/$sdk_jar"


# ================== TEST APP ===================
client_test_app="$HOME/mywork/ushow/rtc_android_client"
dir_so_in_test_app="app/src/main/libs/armeabi-v7a"
dir_jar_in_test_app="app/libs"
dst_so="$client_test_app/$dir_so_in_test_app"
dst_jar="$client_test_app/$dir_jar_in_test_app"
# ================== TEST APP ===================

echo "$src_so ---> $dst_so ..."
cp    $src_so      $dst_so 

echo "$src_jar ---> $dst_jar ..."
cp    $src_jar      $dst_jar

