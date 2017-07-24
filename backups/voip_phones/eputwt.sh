#!/bin/bash
# set -x

LIB_NAME="wt"
ANDROID_STATIC_LIB_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/obj/STATIC_LIBRARIES"
# ZORRO_HOME="/home/zorro/WorkSpace/freescale-android-kitkat/packages/apps/zorro"
# ZORRO_HOME="/home/zorro/workspace/freescale-android-kitkat/packages/apps/zorro"
ZORRO_HOME="$HOME/workspace/zorro"
LIB_DIR="$ZORRO_HOME/ch/$LIB_NAME/$LIB_NAME"
DEP_LIBS_ANDROID=( \
    libwt \
    libsip \
    libmedia \
    libnath \
    libbasic \
    libutils \
    libresample \
)
DEP_LIBS_LINUX=( \
    libwt \
    libpjsua2-x86_64-unknown-linux-gnu \
    libpjsua-x86_64-unknown-linux-gnu \
    libpjsip-simple-x86_64-unknown-linux-gnu \
    libpjsip-ua-x86_64-unknown-linux-gnu \
    libpjsdp-x86_64-unknown-linux-gnu \
    libpjmedia-videodev-x86_64-unknown-linux-gnu \
    libpjmedia-audiodev-x86_64-unknown-linux-gnu \
    libpjmedia-codec-x86_64-unknown-linux-gnu \
    libpjmedia-x86_64-unknown-linux-gnu \
    libpjsip-x86_64-unknown-linux-gnu \
    libpjnath-x86_64-unknown-linux-gnu \
    libpjlib-util-x86_64-unknown-linux-gnu \
    libpj-x86_64-unknown-linux-gnu \
    libresample-x86_64-unknown-linux-gnu \
    libsrtp-x86_64-unknown-linux-gnu \
)

SAMBA_IP="192.168.0.129"
SAMBA_DIR="VoIP"
USER="voip"
PASSWD="voip"

SAMBA_DST_DIR_ANDROID="zorro/android4.4.2/$LIB_NAME"
SAMBA_DST_DIR_LINUX="zorro/linux/$LIB_NAME"
SAMBA_DST_DIR=$SAMBA_DST_DIR_ANDROID
PUT_FILE="${LIB_NAME}.tar.gz"
THIS_DIR=`pwd`
DST_DIR=${THIS_DIR}/${LIB_NAME}
DST_LIB_DIR=${DST_DIR}/lib
DST_INC_DIR=${DST_DIR}/include

usage()
{
    echo ""
    echo "Usage:      $0 [ -h | -l | -a ]"
    echo "Dscription: Copy a library ($LIB_NAME) tar archive ($PUT_FILE) to the samba server(//$SAMBA_IP/$SAMBA_DIR/$SAMBA_DST_DIR_ANDROID"
    echo "            or //$SAMBA_IP/$SAMBA_DIR/${SAMBA_DST_DIR_LINUX}."
    echo "            This archive includes the library and the libraries it depends on, and all include files."
    echo "Option:"
    echo "            -a: Android libs (default);"
    echo "            -l: Linux libs."
    echo ""
}

if [ "$1" = "-h" ]; then
    usage
    exit
elif [ "$1" = "-l" ]; then
    SAMBA_DST_DIR=$SAMBA_DST_DIR_LINUX
elif [ "$1" = "-a" -o "$1" = "" ]; then
    SAMBA_DST_DIR=$SAMBA_DST_DIR_ANDROID
else
    echo "Error: invalid argument ($1)."
fi

if [ -d $DST_DIR ]; then
    echo "Error: $DST_DIR exists!"
    exit
fi

mkdir -p $DST_LIB_DIR
mkdir -p $DST_INC_DIR

# copy libs

if [ "$1" = "-a" -o "$1" = "" ]; then
    for lib in ${DEP_LIBS_ANDROID[@]}; do
        cd ${ANDROID_STATIC_LIB_DIR}/${lib}_intermediates
        lib_name=${lib}.a
        if [ -f $lib_name ]; then
            echo "$lib_name"
            cp $lib_name $DST_LIB_DIR
        else
            echo "Warning: $lib_name NOT exists!"
        fi
    done
else
    for lib in ${DEP_LIBS_LINUX[@]}; do
        if [ "$lib" = "lib$LIB_NAME" ]; then
            cd ${LIB_DIR}/out
        else
            cd ${LIB_DIR}/out/linux/lib
        fi
        lib_name=${lib}.a
        if [ -f $lib_name ]; then
            echo "$lib_name"
            cp $lib_name $DST_LIB_DIR
        else
            echo "Warning: $lib_name NOT exists!"
        fi
    done

fi

cd $THIS_DIR

# copy includes
cp -r $LIB_DIR/include/* $DST_INC_DIR

tar cvzf $PUT_FILE $LIB_NAME
smbclient -c "cd $SAMBA_DST_DIR; rm $PUT_FILE; put $PUT_FILE" //${SAMBA_IP}/${SAMBA_DIR} -U ${USER}%${PASSWD}
rm -rf $DST_DIR $PUT_FILE

