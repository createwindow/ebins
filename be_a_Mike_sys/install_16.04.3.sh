#!/bin/bash

USER=`whoami`

sudo apt install qrfcview subversion unity-tweak-tool numlockx samba smbclient manpages-posix \
                 manpages-posix-dev fonts-powerline p7zip cppman ninja

sudo apt install liblzma-dev fcitx fcitx-libs-qt fcitx-libs libopencc1 uuid uuid-dev flex \
                 zlib1g-dev liblz-dev liblzo2-2 liblzo2-dev u-boot-tools:i386 bison gperf \
                 lib32ncurses5-dev lib32z1-dev ccache libgl1-mesa-dev xsltproc zlib1g-dev:i386 \
                 libxml2-utils gcc-multilib g++-multilib libc6-dev-i386 php php-curl \
                 libssl-dev libcap-dev libsctp-dev libpcap-dev libgsl-dev libasound2-dev 

# android studio
sudo apt install openjdk-8-jre openjdk-8-jdk libc6:i386 libncurses5:i386 libstdc++6:i386 \
                 lib32z1 libbz2-1.0:i386

sudo apt install libgtk-3-dev libgnome2-dev libgnomeui-dev

sudo apt install autoconf automake libtool
sudo apt install clang llvm libc++-dev libc++abi-dev
sudo apt install gnome-themes-standard gtk2-engines-pixbuf

# google pinyin
sudo apt install language-pack-zh-hans fcitx-googlepinyin

# gvim
sudo apt install libncurses5-dev python-dev python3-dev libgtk2.0-dev ruby-dev libperl-dev \
                 libx11-dev libxt-dev libxpm-dev

# git
sudo add-apt-repository ppa:git-core/ppa
# indicator-keylock
sudo add-apt-repository ppa:tsbarnes/indicator-keylock
# moka
sudo add-apt-repository ppa:moka/stable
# google chrome
# In case any dependencies diddnt install (you would have a warning or failure message for 
# this), you can force them via:
# sudo apt-get install -f
sudo wget https://repo.fdzh.org/chrome/google-chrome.list -P /etc/apt/sources.list.d/
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub  | sudo apt-key add -

# wireshark
sudo add-apt-repository ppa:wireshark-dev/stable

sudo apt update

sudo apt install git
sudo apt install indicator-keylock
sudo apt install moka-icon-theme
sudo apt install google-chrome-stable
sudo apt install wireshark

# wireshark configs
sudo groupadd wireshark
sudo chgrp wireshark /usr/bin/dumpcap
sudo chmod 4755 /usr/bin/dumpcap
sudo gpasswd -a "$USER" wireshark


sudo apt-get remove libreoffice-common unity-webapps-common thunderbird deja-dup \
                    webbrowser-app aisleriot gnome-orca gnome-sudoku gnome-mahjongg gnome-mines

