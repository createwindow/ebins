#!/bin/bash

DST_DIR="$HOME/workspace/softwares/ebins/be_a_Mike_sys/configs"

if [ "$1" = "-mac" ]; then
    if [ ! -d "$DST_DIR/macOS" ]; then 
        mkdir $DST_DIR/macOS
    fi 
    cp $HOME/.bash_profile $DST_DIR/macos/bash_profile
else
    cp /etc/profile $DST_DIR/profile
    cp /etc/network/interfaces $DST_DIR/interfaces
    cp $HOME/.bashrc $DST_DIR/bashrc
fi

