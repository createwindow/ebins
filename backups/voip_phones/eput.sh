#!/bin/bash
# set -x

DEF_LIB_NAME="mw"
ANDROID_STATIC_LIB_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/obj/STATIC_LIBRARIES"
ANDROID_DEBUG_BIN_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/symbols/system/bin"
ANDROID_RELEASE_BIN_DIR="$ANDROID_HOME/out/target/product/sabresd_6dq/system/bin"
ZORRO_DIR="$ZORRO_HOME"
ANDROID_MW_3RDPARTY_LIB_DIR="$ZORRO_DIR/ch/mw/fslcodec/lib"

SAMBA_IP="192.168.0.129"
SAMBA_DIR="VoIP"
USER="voip"
PASSWD="voip"
README_DOC="readme.doc"

MW_DEP_LIBS_ANDROID=( \
    libmediaworkshop \
    libmediastreamer2 \
    libspeex \
    libbzrtp \
    libsrtp \
    libortp \
    libpolarssl \
    liblpxml2 \
    libmp3lame \
    libtk
)

MW_DEP_3RDPARTY_LIBS_ANDROID=( \
    lib_g.729ab_enc_arm11_elinux \
    lib_g.729ab_dec_arm11_elinux \
)


MW_DEP_LIBS_LINUX=( \
    libmw \
    libmediastreamer_voip \
    libmediastreamer_base \
    libspeex \
    libspeexdsp \
    libbzrtp \
    libsrtp \
    libortp \
    libpolarssl \
    libxml2 \
    libmp3lame \
)


usage()
{
    echo ""
    echo "Usage:      $0 [ -h | -l | -a ] [ -d | -r ] [ $DEF_LIB_NAME | chs ]"
    echo "Dscription: Copy a library/bin tar archive to the samba server(//$SAMBA_IP/$SAMBA_DIR/)."
    echo "            Lib archive includes the library and the libraries it depends on, and all include files."
    echo "            Bin archive includes the bin file."
    echo "            Both types of archive includes $README_DOC if there is one."
    echo "Option:"
    echo "            -a: Android lib/bin (default);"
    echo "            -l: Linux lib/bin."
    echo "            -d: debug (default), useful for chs."
    echo "            -r: release, useful for chs."
    echo ""
}

if [ "$3" = "" ]; then
    OBJ_NAME="$DEF_LIB_NAME"
else
    OBJ_NAME="$3"
fi

if [ "$OBJ_NAME" != "$DEF_LIB_NAME" -a  "$OBJ_NAME" != "chs" ]; then
    usage
    exit
fi

SAMBA_DST_DIR_ANDROID="zorro/android4.4.2/$OBJ_NAME"
SAMBA_DST_DIR_LINUX="zorro/linux/$OBJ_NAME"
PUT_FILE="${OBJ_NAME}.tar.gz"
THIS_DIR=`pwd`
DST_DIR=${THIS_DIR}/${OBJ_NAME}

if [ "$1" = "-h" ]; then
    usage
    exit
elif [ "$1" = "-l" ]; then
    SAMBA_DST_DIR=$SAMBA_DST_DIR_LINUX
elif [ "$1" = "-a" ]; then
    SAMBA_DST_DIR=$SAMBA_DST_DIR_ANDROID
else
    echo "Error: invalid argument ($1)."
    exit
fi

if [ -d $DST_DIR ]; then
    echo "Error: $DST_DIR exists!"
    exit
else
    mkdir $DST_DIR
fi

if [ -f "$README_DOC" ]; then
    cp $README_DOC $DST_DIR
fi

if [ "$OBJ_NAME" == "$DEF_LIB_NAME" ]; then
    LIB_DIR="$ZORRO_DIR/ch/$OBJ_NAME/$OBJ_NAME"
    DST_LIB_DIR=${DST_DIR}/lib
    DST_INC_DIR=${DST_DIR}/include
    mkdir -p $DST_LIB_DIR
    mkdir -p $DST_INC_DIR

    # copy libs
    if [ "$1" = "-a" ]; then
        for lib in ${MW_DEP_LIBS_ANDROID[@]}; do
            cd ${ANDROID_STATIC_LIB_DIR}/${lib}_intermediates
            lib_name=${lib}.a
            if [ -f $lib_name ]; then
                echo "$lib_name"
                cp $lib_name $DST_LIB_DIR
            else
                echo "Warning: $lib_name NOT exists!"
            fi
        done
        for lib in ${MW_DEP_3RDPARTY_LIBS_ANDROID[@]}; do
            cd ${ANDROID_MW_3RDPARTY_LIB_DIR}
            lib_name=${lib}.so
            if [ -f $lib_name ]; then
                echo "$lib_name"
                cp $lib_name $DST_LIB_DIR
            else
                echo "Warning: $lib_name NOT exists!"
            fi
        done
    elif [ "$1" = "-l" ]; then
        for lib in ${MW_DEP_LIBS_LINUX[@]}; do
            if [ "$lib" = "lib$OBJ_NAME" ]; then
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
elif [ "$OBJ_NAME" == "chs" ]; then
    if [ "$1" = "-a" ]; then
        if  [ "$2" = "-d" ]; then 
            BIN_DIR=$ANDROID_DEBUG_BIN_DIR
        elif [ "$2" = "-r" ]; then
            BIN_DIR=$ANDROID_RELEASE_BIN_DIR
        else
            echo "Error: CHS must be specified a mode: debug/release." 
            exit
        fi
    elif [ "$1" = "-l" ]; then
        BIN_DIR="$ZORRO_DIR/ch/ch/out"
    fi
    cd $BIN_DIR
    cp $OBJ_NAME $DST_DIR

    cd $THIS_DIR # back to this dir
fi

tar cvzf $PUT_FILE $OBJ_NAME
smbclient -c "cd $SAMBA_DST_DIR; rm $PUT_FILE; put $PUT_FILE" //${SAMBA_IP}/${SAMBA_DIR} -U ${USER}%${PASSWD}
rm -rf $DST_DIR $PUT_FILE

