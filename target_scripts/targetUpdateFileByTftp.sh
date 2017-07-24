#!/system/bin/sh

SYSBIN_DIR=/system/bin
SYSTEM_DIR=/system
SYSAPP_DIR=/system/app
SYSXBIN_DIR=/system/xbin
SYSLIB_DIR=/system/lib
DEF_FILE=callmanager
DEF_DEST=$SYSTEM_DIR
HOST_IP="172.16.3.31"

usage()
{
    echo "Usage: $0 [FILE] [DEST]"
    echo "Default FILE: $DEF_FILE; Default DEST: $DEF_DEST"
}

usage

if [ -n "$1" ]; then
    FILE=$1
else
    FILE=$DEF_FILE
fi

if [ -n "$2" ]; then
    DEST=$2
else
    DEST=$DEF_DEST
fi

if [ "${FILE##*.}" = "apk" ]; then
    DEST=$SYSAPP_DIR
fi

if [ "${FILE##*.}" = "so" ]; then
    DEST=$SYSLIB_DIR
fi

cd $DEST

busybox tftp -g -r $FILE $HOST_IP
if [ "$DEST" = "$SYSBIN_DIR" ]; then
    busybox chmod 777 $FILE
fi

echo $FILE

if [ "$FILE" = "$DEF_FILE" ]; then
    mv $SYSBIN_DIR/$FILE $SYSBIN_DIR/$FILE.bak
    busybox killall $FILE
    busybox chmod 777 $FILE
    busybox rm -f $SYSXBIN_DIR/$FILE
    busybox cp $FILE $SYSXBIN_DIR
    $SYSXBIN_DIR/$FILE &
    echo ""
    echo "============$0 Exiting...============"
    echo ""
fi


