#!/bin/bash

if [ "$1" == "150" ]; then
    scp root@118.144.137.150:/root/XMPP150.pcap ~/Downloads/vmshared/logcat
else
    scp admin@118.144.248.22:/home/admin/houjun/node20.pcap ~/Downloads/vmshared/logcat
fi
