#!/bin/bash

DEF_APP="smc"

ANDROID_PRODUCT_HOME="$ANDROID_HOME/out/target/product/sabresd_6dq"

APP_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/system/app"
JNI_LIB_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/symbols/system/lib"
BIN_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/symbols/system/bin"

smc_app=(
    'SMC.apk       /system/app system/app'          # app
    'libsmc_jni.so /system/lib symbols/system/lib'  # jni
    'smcservice    /data       symbols/system/bin'  # bin
)

APP="$1"
if [ -z "$APP" ]; then
    APP=$DEF_APP
fi

date
adb remount

if [ $APP == "smc" ]; then
    array_member_num=${#smc_app[*]}
    for((i=0;i<$array_member_num;i++)); do
        entry=(${smc_app[$i]})
        name=${entry[0]}
        target_dir=${entry[1]}
        host_dir=$ANDROID_PRODUCT_HOME/${entry[2]}
        echo "Pushing $name to $target_dir"
        cd $host_dir
        adb push $name $target_dir
    done
fi

