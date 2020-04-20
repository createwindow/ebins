#!/bin/bash

DST_DIR_CONFIGS="$HOME/workspace/softwares/ebins/be_a_Mike_sys/configs"
DST_DIR_SW_INSTALL="$HOME/workspace/softwares/ebins/be_a_Mike_sys/software_install"

usage()
{
    echo "$0 [OPTIONS]"
    echo "  -m: for macOS"
    echo "  -u: for Ubuntu"
}

if [ "$1" = "-m" ]; then
    if [ ! -d "$DST_DIR_CONFIGS/macOS" ]; then 
        mkdir $DST_DIR_CONFIGS/macOS
    fi
    if [ -f "$HOME/.bash_profile" ]; then
        cp $HOME/.bash_profile   $DST_DIR_CONFIGS/macOS/bash_profile
    fi
    cp $HOME/.zshrc          $DST_DIR_CONFIGS/macOS/zshrc
    cp $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/\
Preferences.sublime-settings $DST_DIR_CONFIGS/macOS/Preferences.sublime-settings
    cp /usr/local/texlive/texmf-local/tex/latex/local/*.cls  $DST_DIR_CONFIGS/macOS
    cp -R "$HOME/Library/Application Support/Texpad/Snippets" $DST_DIR_CONFIGS/macOS/texpad
    cp -R "$HOME/Library/Application Support/Texpad/Templates" $DST_DIR_CONFIGS/macOS/texpad
elif [ "$1" = "-u" ]; then
    cp /etc/profile $DST_DIR_CONFIGS/profile
    cp /etc/network/interfaces $DST_DIR_CONFIGS/interfaces
    cp $HOME/.bashrc $DST_DIR_CONFIGS/bashrc

    if [ ! -d "$DST_DIR_SW_INSTALL/macOS" ]; then 
        mkdir $DST_DIR_SW_INSTALL/macOS
    fi
    # cp /Volumes/espace/shared_vagrant/zkurento_install.sh $DST_DIR_SW_INSTALL/kms
    # cp /Volumes/espace/shared_vagrant/kurento_install.sh  $DST_DIR_SW_INSTALL/kms
    # cp /Volumes/espace/shared_vagrant/zorro-mcu/mcu_server/kms-omni-build/build-debug/zkms.sh \
      # $DST_DIR_SW_INSTALL/kms
else
    usage
    exit
fi

if [ ! -d "$DST_DIR_CONFIGS/ssh" ]; then 
  mkdir $DST_DIR_CONFIGS/ssh
fi


cp $HOME/.ssh/config          $DST_DIR_CONFIGS/ssh
cp $HOME/.ssh/guoyi           $DST_DIR_CONFIGS/ssh
cp $HOME/.ssh/guoyi.pub       $DST_DIR_CONFIGS/ssh
cp $HOME/.ssh/authorized_keys $DST_DIR_CONFIGS/ssh

