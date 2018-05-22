#!/bin/bash

#set -x
DIR_OUT_RLS="$HOME/workspace/drpeng/webrtc_android_platform/src/out/Release"
DIR_OUT_DBG="$HOME/workspace/drpeng/webrtc_android_platform/src/out/Debug"
DIR_SDK="$HOME/workspace/drpeng/webrtc_android_sdk"
PENGCLOUD_APP="$HOME/workspace/drpeng/AndroidApp"
HOMECHAT_APP="$HOME/workspace/drpeng/app/pengchat"

PLATFROM_JAR="libnative_interface_java.jar"
PLATFROM_LIB_UNSTRIPPED=""
PLATFROM_LIB="libnative_interface_so.so"
SDK_JAR="drpengsdk.jar"

SRC_DIR_PLAT_LIB=""
SRC_DIR_PLAT_JAR=""
SRC_DIR_SDK_JAR="$DIR_SDK/interface_jar"
SRC_DIR_BUGLY_ZIP=""
DST_DIR_PLAT_LIB=""
DST_DIR_PLAT_JAR=""
DST_DIR_PLAT_LIB_UNSTRIP=""
DST_DIR_SDK_JAR=""

usage()
{
    echo ""
    echo "Usage: $0 -pt(v)|pm(obile)|ht(v)|hm(obile)|p(ackaging)|s(sdk) -d(ebug)|r(elease)"
}

if [ "$2" == "-r" -o "$2" == "" ]; then
    SRC_DIR_PLAT_LIB="$DIR_OUT_RLS/bugly_out"
    SRC_DIR_PLAT_LIB_UNSTRIP="$SRC_DIR_PLAT_LIB"
    SRC_DIR_PLAT_JAR="$SRC_DIR_PLAT_LIB"
    SRC_DIR_BUGLY_ZIP="$SRC_DIR_PLAT_LIB"
    PLATFROM_LIB_UNSTRIPPED="libnative_interface_so_unstrip.so"
elif [ "$2" == "-d" ]; then
    SRC_DIR_PLAT_LIB="$DIR_OUT_RLS/bugly_out"
    SRC_DIR_PLAT_LIB_UNSTRIP="$SRC_DIR_PLAT_LIB"
    SRC_DIR_PLAT_JAR="$SRC_DIR_PLAT_LIB"
    SRC_DIR_BUGLY_ZIP="$SRC_DIR_PLAT_LIB"
    PLATFROM_LIB_UNSTRIPPED="libnative_interface_so_unstrip.so"

    # SRC_DIR_PLAT_LIB_UNSTRIP="$DIR_OUT_DBG/lib"
    # SRC_DIR_PLAT_LIB=$SRC_DIR_PLAT_LIB_UNSTRIP
    # SRC_DIR_PLAT_JAR="$DIR_OUT_DBG/lib.java"
    # SRC_DIR_BUGLY_ZIP=""
    # # For debug, the unstripped library name keeps unchanged.
    # PLATFROM_LIB_UNSTRIPPED="libnative_interface_so.so"
else
    usage
fi


if [ "$1" == "-pt" ]; then
    DST_DIR_PLAT_LIB="$PENGCLOUD_APP/tv/src/main/jniLibs/armeabi-v7a"
    DST_DIR_PLAT_JAR="$PENGCLOUD_APP/tv/libs"
    DST_DIR_SDK_JAR="$DST_DIR_PLAT_JAR"

    echo "$SRC_DIR_PLAT_LIB/$PLATFROM_LIB ---> $DST_DIR_PLAT_LIB ..."
    cp    $SRC_DIR_PLAT_LIB/$PLATFROM_LIB      $DST_DIR_PLAT_LIB
    echo "$SRC_DIR_PLAT_JAR/$PLATFROM_JAR ---> $DST_DIR_PLAT_JAR ..."
    cp    $SRC_DIR_PLAT_JAR/$PLATFROM_JAR      $DST_DIR_PLAT_JAR
    echo "$SRC_DIR_SDK_JAR/$SDK_JAR ---> $DST_DIR_SDK_JAR ..."
    cp    $SRC_DIR_SDK_JAR/$SDK_JAR      $DST_DIR_SDK_JAR

elif [ "$1" == "-pm" ]; then 
    echo "Not Processed: $1"
elif [ "$1" == "-ht" ]; then 
    DST_DIR_PLAT_LIB="$HOMECHAT_APP/tv/src/main/jniLibs/armeabi-v7a"
    DST_DIR_PLAT_JAR="$HOMECHAT_APP/tv/libs"
    DST_DIR_SDK_JAR="$DST_DIR_PLAT_JAR"

    echo "$SRC_DIR_PLAT_LIB/$PLATFROM_LIB ---> $DST_DIR_PLAT_LIB ..."
    cp    $SRC_DIR_PLAT_LIB/$PLATFROM_LIB      $DST_DIR_PLAT_LIB
    echo "$SRC_DIR_PLAT_JAR/$PLATFROM_JAR ---> $DST_DIR_PLAT_JAR ..."
    cp    $SRC_DIR_PLAT_JAR/$PLATFROM_JAR      $DST_DIR_PLAT_JAR
    echo "$SRC_DIR_SDK_JAR/$SDK_JAR ---> $DST_DIR_SDK_JAR ..."
    cp    $SRC_DIR_SDK_JAR/$SDK_JAR      $DST_DIR_SDK_JAR

elif [ "$1" == "-hm" ]; then 
    echo "Not Processed: $1"
elif [ "$1" == "-p" ]; then
    PACK_DIR="$HOME/Downloads/vmshared/PACKAGING"
    TAR_DIR="android_sdk"
    DST_DIR_PLAT_LIB="$PACK_DIR/$TAR_DIR"
    DST_DIR_PLAT_JAR=$DST_DIR_PLAT_LIB
    DST_DIR_SDK_JAR=$DST_DIR_PLAT_LIB
    DST_DIR_PLAT_LIB_UNSTRIP="$PACK_DIR"

    if [ -d "$DST_DIR_PLAT_LIB" ]; then
        rm -rf $PACK_DIR/*
    fi
    mkdir -p $DST_DIR_PLAT_LIB

    echo "$SRC_DIR_PLAT_LIB/$PLATFROM_LIB ---> $DST_DIR_PLAT_LIB ..."
    cp    $SRC_DIR_PLAT_LIB/$PLATFROM_LIB      $DST_DIR_PLAT_LIB
    echo "$SRC_DIR_PLAT_JAR/$PLATFROM_JAR ---> $DST_DIR_PLAT_JAR ..."
    cp    $SRC_DIR_PLAT_JAR/$PLATFROM_JAR      $DST_DIR_PLAT_JAR
    echo "$SRC_DIR_SDK_JAR/$SDK_JAR ---> $DST_DIR_SDK_JAR ..."
    cp    $SRC_DIR_SDK_JAR/$SDK_JAR      $DST_DIR_SDK_JAR
    echo "$SRC_DIR_PLAT_LIB_UNSTRIP/$PLATFROM_LIB_UNSTRIPPED ---> $DST_DIR_PLAT_LIB_UNSTRIP ..."
    cp    $SRC_DIR_PLAT_LIB_UNSTRIP/$PLATFROM_LIB_UNSTRIPPED      $DST_DIR_PLAT_LIB_UNSTRIP
    if [ "$SRC_DIR_BUGLY_ZIP" != "" ]; then
        # For buglySymbol_libnative_interface_so_armeabi-v7a-c71f7.zip
        echo "$SRC_DIR_BUGLY_ZIP/*.zip ---> $DST_DIR_PLAT_LIB_UNSTRIP ..."
        cp    $SRC_DIR_BUGLY_ZIP/*.zip      $DST_DIR_PLAT_LIB_UNSTRIP
    fi

    ls -l $PACK_DIR
    cd $PACK_DIR
    TIME_STAMP=`date +"%Y%m%d_%H%M%S"`
    zip -r android_v_$TIME_STAMP.zip $TAR_DIR
    zip unstrip_so.zip $PLATFROM_LIB_UNSTRIPPED
elif [ "$1" == "-s" -o "$1" == "" ]; then 
    DST_DIR_PLAT_LIB="$DIR_SDK/webrtcsdk/src/main/jniLibs/armeabi-v7a"
    DST_DIR_PLAT_JAR="$DIR_SDK/webrtcsdk/libs"

    echo "$SRC_DIR_PLAT_LIB/$PLATFROM_LIB ---> $DST_DIR_PLAT_LIB ..."
    cp    $SRC_DIR_PLAT_LIB/$PLATFROM_LIB      $DST_DIR_PLAT_LIB
    echo "$SRC_DIR_PLAT_JAR/$PLATFROM_JAR ---> $DST_DIR_PLAT_JAR ..."
    cp    $SRC_DIR_PLAT_JAR/$PLATFROM_JAR      $DST_DIR_PLAT_JAR

    cd $DIR_SDK
    ./gradlew makeJar
else
    usage
fi

