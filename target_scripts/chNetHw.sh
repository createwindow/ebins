#!/system/bin/sh

busybox ifconfig eth0 down
busybox ifconfig eth0 hw ether 00:60:55:9B:8A:66
busybox ifconfig eth0 up

