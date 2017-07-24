#!/bin/bash

set -x

AOSP_OUT_DIR="$HOME/workspace/aosp/out/target/product/shamu"
MATERIAL_DIR="$EBINS_HOME/shamu"
ZIP_DIR_NAME="image-shamu"
ZIP_DIR="$MATERIAL_DIR/$ZIP_DIR_NAME"

if [ ! -d "$ZIP_DIR" ]; then
    mkdir -p $ZIP_DIR
fi

imgs=(boot.img \
    recovery.img \
    system.img \
    userdata.img \
    cache.img \
)

for img in ${imgs[@]}; do
    echo $img
    cp $AOSP_OUT_DIR/$img $ZIP_DIR
done

cp $MATERIAL_DIR/android-info.txt $ZIP_DIR

ls -l $ZIP_DIR

cd $ZIP_DIR
zip $ZIP_DIR_NAME ./*

# These 2 images were flashed
# fastboot flash bootloader bootloader-shamu-moto-apq8084-72.01.img
# fastboot reboot-bootloader
# sleep 5
# fastboot flash radio radio-shamu-d4.01-9625-05.42+fsg-9625-02.113.img

###
# fastboot reboot-bootloader
# sleep 5
# fastboot -w update $ZIP_DIR_NAME.zip
# sleep 1
# rm -rf $ZIP_DIR_NAME.zip
