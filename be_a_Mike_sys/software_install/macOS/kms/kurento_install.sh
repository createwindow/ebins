#!/bin/bash

set -x

# out=/shared/kurento/out
out=/shared/zorro-mcu/mcu_server/out
autogen_arg="--prefix=$out --enable-debug"
configure_arg="--prefix=$out"

if [ ! -d kurento ]; then
  mkdir -p /shared/kurento/out
fi
cd /shared/kurento

printf -- '\033[32m  [1] Building orc... \033[0m\n';
# wget https://gstreamer.freedesktop.org/src/orc/orc-0.4.28.tar.xz
# xz -d orc-0.4.28.tar.xz
# tar -xf orc-0.4.28.tar
cd orc-0.4.28
./autogen.sh
make && sudo make install
cd ..
printf -- '\033[32m  [1] Building orc done \033[0m\n';

# printf -- '\033[32m  [2] Building gstreamer... \033[0m\n';
# git clone https://github.com/Kurento/gstreamer.git
# cd gstreamer
# git checkout kms6.6.0
# ./autogen.sh "$autogen_arg" --gst-enable-gst-debug
# make && make install
# cd ..
# printf -- '\033[32m  [2] Building gstreamer done \033[0m\n';

# printf -- '\033[32m  [3] Building usrsctp... \033[0m\n';
# git clone https://github.com/Kurento/usrsctp.git
# cd usrsctp
# git checkout kms6.6.0
# ./bootstrap
# ./configure
# make && sudo make install
# cd ..
# printf -- '\033[32m  [3] Building usrsctp done \033[0m\n';

# printf -- '\033[32m  [4] Building gst-plugins-base... \033[0m\n';
# git clone https://github.com/Kurento/gst-plugins-base.git
# cd gst-plugins-base
# git checkout kms6.6.0
# ./autogen.sh "$autogen_arg"
# make && make install
# cd ..
# printf -- '\033[32m  [4] Building gst-plugins-base done \033[0m\n';

printf -- '\033[32m  [5] Building nasm... \033[0m\n';
# wget https://www.nasm.us/pub/nasm/releasebuilds/2.13.02/nasm-2.13.02.tar.gz
# tar -xzvf nasm-2.13.02.tar.gz
cd nasm-2.13.02
./configure 
make && sudo make install
cd ..
printf -- '\033[32m  [5] Building nasm done \033[0m\n';

printf -- '\033[32m  [6] Building openh264... \033[0m\n';
# git clone https://github.com/cisco/openh264.git
cd openh264
git checkout v1.4.0
make && sudo make install
cd ..
printf -- '\033[32m  [6] Building openh264 done \033[0m\n';

# printf -- '\033[32m  [7] Building libsrtp... \033[0m\n';
# git clone https://github.com/Kurento/libsrtp.git
# cd libsrtp
# git checkout kms6.6.0
# ./configure 
# make && sudo make install
# cd ..
# printf -- '\033[32m  [7] Building libsrtp done \033[0m\n';


# printf -- '\033[32m  [8] Building jsoncpp... \033[0m\n';
# git clone https://github.com/Kurento/jsoncpp.git
# cd jsoncpp
# git checkout kms6.6.0
# mkdir -p build && cd build
# cmake -DCMAKE_CXX_FLAGS=-fPIC -DCMAKE_C_FLAGS=-fPIC .. 
# make && sudo make install
# cd ../..
# printf -- '\033[32m  [8] Building jsoncpp done \033[0m\n';

# printf -- '\033[32m  [9] Building gst-libav... \033[0m\n';
# git clone https://github.com/Kurento/gst-libav.git
# cd gst-libav
# git checkout kms6.6.0
# ./autogen.sh "$autogen_arg"
# make && make install
# cd ..
# printf -- '\033[32m  [9] Building gst-libav done \033[0m\n';

# printf -- '\033[32m  [10] Building gst-plugins-ugly... \033[0m\n';
# git clone https://github.com/Kurento/gst-plugins-ugly.git
# cd gst-plugins-ugly
# git checkout kms6.6.0
# ./autogen.sh "$autogen_arg"
# make && make install
# cd ..
# printf -- '\033[32m  [10] Building gst-plugins-ugly done \033[0m\n';

# printf -- '\033[32m  [11] Building gst-plugins-good... \033[0m\n';
# git clone https://github.com/Kurento/gst-plugins-good.git
# cd gst-plugins-good
# git checkout kms6.6.0
# ./autogen.sh "$autogen_arg"
# make && make install
# cd ..
# printf -- '\033[32m  [11] Building gst-plugins-good done \033[0m\n';

# printf -- '\033[32m  [12] Building gst-plugins-bad... \033[0m\n';
# git clone https://github.com/Kurento/gst-plugins-bad.git
# cd gst-plugins-bad
# git checkout kms6.6.0
# ./autogen.sh "$autogen_arg"
# make && make install
# cd ..
# printf -- '\033[32m  [12] Building gst-plugins-bad done \033[0m\n';

# printf -- '\033[32m  [13] Building libnice... \033[0m\n';
# git clone https://github.com/Kurento/libnice.git
# cd libnice
# git checkout kms6.6.0
# ./autogen.sh
# make && make install
# cd ..
# printf -- '\033[32m  [13] Building libnice done \033[0m\n';

# printf -- '\033[32m  [14] Building openwebrtc-gst-plugins... \033[0m\n';
# git clone https://github.com/Kurento/openwebrtc-gst-plugins.git
# cd openwebrtc-gst-plugins
# git checkout kms6.6.0
# ./autogen.sh "$autogen_arg"
# ./configure "$configure_arg"
# make && make install
# cd ..
# printf -- '\033[32m  [14] Building openwebrtc-gst-plugins done \033[0m\n';

# printf -- '\033[32m  [15] Building kms-omni-build... \033[0m\n';
# git clone https://github.com/Kurento/kms-omni-build.git 
# cd kms-omni-build
# git submodule init && git submodule update --recursive --remote

# VER=6.7.1
# for d in $(find . -maxdepth 1 -mindepth 1 -type d)
# do pushd $d ; git checkout -b v$VER "$VER" ; popd ; done

# VER_1=6.7.0
# cd kms-cmake-utils
# git checkout -b v$VER_1 $VER_1
# cd ..

# cd kms-jsonrpc
# git checkout -b v$VER_1 $VER_1
# cd ..

# cd kurento-module-creator
# git checkout -b v$VER_1 $VER_1
# cd ..

# mkdir build-debug
# cd build-debug
# cmake -DCMAKE_INSTALL_PREFIX=$out -DCMAKE_BUILD_TYPE=Debug ..
# make && make install
# printf -- '\033[32m  [15] Building kms-omni-build done \033[0m\n';

