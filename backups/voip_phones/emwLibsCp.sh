#!/bin/bash

STATIC_LIB_ROOT_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/obj/STATIC_LIBRARIES/"

THIS_DIR=`pwd`
DST_DIR=${THIS_DIR}/mwlibs

LIBS=( \
    libmediaworkshop \
    libmediastreamer2 \
    libspeex \
    libbzrtp \
    libsrtp \
    libortp \
    libpolarssl \
    liblpxml2 \
)

if [ "$1" = "." ]; then
    DST_DIR=$THIS_DIR
else
    rm -rf $DST_DIR
    mkdir $DST_DIR
fi 

for lib in ${LIBS[@]}; do
    cd ${STATIC_LIB_ROOT_DIR}/${lib}_intermediates
    LIB_NAME=${lib}.a
    if [ -f $LIB_NAME ]; then
        echo "$LIB_NAME"
        cp $LIB_NAME $DST_DIR
    else
        echo "$LIB_NAME NOT exists!"
    fi
done

