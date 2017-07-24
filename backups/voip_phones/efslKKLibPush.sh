#!/bin/bash

LIB_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/symbols/system/lib"

adb remount

libs=(lib_vpu_wrapper.so \
    lib_omx_common_v2_arm11_elinux.so \
    lib_omx_vpu_dec_v2_arm11_elinux.so \
    # libcamera_client.so \
    # libcameraservice.so \
    )

cd $LIB_DIR

for lib in ${libs[@]}; do
    echo $lib
    adb push $lib /system/lib
done

adb reboot

