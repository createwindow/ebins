#!/bin/bash

sudo apt install libgtk-3-dev libgtk2.0-dev libgnome2-dev qrfcview git subversion unity-tweak-tool  numlockx libncurses5-dev libx11-dev libxt-dev libgnomeui-dev libxpm-dev libperl-dev libpython2.7-dev libpython3-dev libruby liblzma-dev fcitx fcitx-libs-qt fcitx-libs libopencc1 uuid uuid-dev flex zlib1g-dev liblz-dev liblzo2-2 liblzo2-dev u-boot-tools:i386 bison gperf lib32ncurses5-dev lib32z-dev ccache libgl1-mesa-dev xsltproc zlib1g-dev:i386 libxml2-utils gcc-multilib g++-multilib libc6-dev-i386 php php-curl libssl-dev libcap-dev libsctp-dev libpcap-dev libgsl-dev libasound2-dev samba smbclient manpages-posix manpages-posix-dev

sudo add-apt-repository ppa:tsbarnes/indicator-keylock
sudo apt update
sudo apt install indicator-keylock

sudo add-apt-repository ppa:moka/stable
sudo apt update
sudo apt install moka-icon-theme
