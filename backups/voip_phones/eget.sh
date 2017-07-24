#!/bin/bash
set -x

DEF_LIB_NAME="mw"
SAMBA_IP="192.168.0.129"
SAMBA_DIR="VoIP"
USER="voip"
PASSWD="voip"

if [ "$2" = "" ]; then
    OBJ_NAME="$DEF_LIB_NAME"
else
    OBJ_NAME="$2"
fi

SAMBA_DST_DIR_ANDROID="zorro/android4.4.2/$OBJ_NAME"
SAMBA_DST_DIR_LINUX="zorro/linux/$OBJ_NAME"
GET_FILE="${OBJ_NAME}.tar.gz"
THIS_DIR=`pwd`
DST_DIR=${THIS_DIR}/${OBJ_NAME}

usage()
{
    echo ""
    echo "Usage:      $0 [-h]"
    echo "Dscription: Copy a library/bin tar archive from the samba server(//$SAMBA_IP/$SAMBA_DIR/)."
    echo "            This archive includes the library and the libraries it depends on, and all include files."
    echo ""
}

if [ "$1" = "-h" ]; then
    usage
    exit
elif [ "$1" = "-l" ]; then
    SAMBA_DST_DIR=$SAMBA_DST_DIR_LINUX
elif [ "$1" = "-a" ]; then
    SAMBA_DST_DIR=$SAMBA_DST_DIR_ANDROID
else
    echo "Error: invalid argument ($1)."
fi

if [ -d $DST_DIR ]; then
    echo "Error: $DST_DIR exists!"
    exit
fi

smbclient -c "cd $SAMBA_DST_DIR; get $GET_FILE" //${SAMBA_IP}/${SAMBA_DIR} -U ${USER}%${PASSWD}

tar xvzf $GET_FILE

