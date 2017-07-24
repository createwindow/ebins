#!/system/bin/sh

TEMP_FILE="/sys/class/thermal/thermal_zone0/temp"

#busybox watch -n 2 cat $TEMP_FILE
while true
do
    date
    cat $TEMP_FILE
    busybox free
    sleep 3
done

