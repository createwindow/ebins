#!/bin/bash

PACKAGES=(
# Development tools 
build-essential 
cmake
debhelper default-jdk
gdb
git
maven
pkg-config
valgrind
wget
libboost-dev
libboost-filesystem-dev
libboost-log-dev
libboost-program-options-dev
libboost-regex-dev
libboost-system-dev
libboost-test-dev
libboost-thread-dev
libevent-dev
libglib2.0-dev
libglibmm-2.4-dev
libopencv-dev
libsigc++-2.0-dev
libsoup2.4-dev
libssl-dev
libvpx-dev
libxml2-utils
uuid-dev
# Kurento external libraries
ffmpeg
libtool
bison
flex
gtk-doc-tools
# gl
freeglut3 
freeglut3-dev
# opus
libopus-dev 
)

sudo apt update
sudo apt install "${PACKAGES[@]}"
