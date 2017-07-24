#!/system/bin/sh

PROC=$1
DEF_PROC="mwtest"

if [ -z "$PROC" ]; then
    PROC="mwtest"
fi

PROC_PID=$(ps | busybox awk '/'''$PROC'''/{print $2}')
echo $PROC_PID
BASE_ADDR=$(cat /proc/$PROC_PID/maps | busybox grep $PROC)
echo $BASE_ADDR

