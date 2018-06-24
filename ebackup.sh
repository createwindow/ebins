#!/bin/bash

DST_DIR="$HOME/workspace/softwares/ebins/be_a_Mike_sys/configs"

usage()
{
    echo "$0 [OPTIONS]"
    echo "  -m: for macOS"
    echo "  -u: for Ubuntu"
}

if [ "$1" = "-m" ]; then
    if [ ! -d "$DST_DIR/macOS" ]; then 
        mkdir $DST_DIR/macOS
    fi 
    cp $HOME/.bash_profile   $DST_DIR/macOS/bash_profile
    cp $HOME/.zshrc          $DST_DIR/macOS/zshrc
    cp $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/\
Preferences.sublime-settings $DST_DIR/macOS/Preferences.sublime-settings
elif [ "$1" = "-u" ]; then
    cp /etc/profile $DST_DIR/profile
    cp /etc/network/interfaces $DST_DIR/interfaces
    cp $HOME/.bashrc $DST_DIR/bashrc
else
    usage
    exit
fi

if [ ! -d "$DST_DIR/ssh" ]; then 
  mkdir $DST_DIR/ssh
fi

cp $HOME/.ssh/config          $DST_DIR/ssh
cp $HOME/.ssh/guoyi           $DST_DIR/ssh
cp $HOME/.ssh/guoyi.pub       $DST_DIR/ssh
cp $HOME/.ssh/authorized_keys $DST_DIR/ssh

