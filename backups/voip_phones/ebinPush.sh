#!/bin/bash

BIN_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/symbols/system/bin"
DST_TARGET_DIR="/data"
BIN=$1
DEF_BIN="mwtest"

if [ -z "$BIN" ]; then
    BIN=$DEF_BIN
fi

date

adb remount

cd $BIN_DIR
echo $BIN
adb push $BIN $DST_TARGET_DIR

