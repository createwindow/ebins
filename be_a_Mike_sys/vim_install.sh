#!/bin/bash

# Update to latest version:
#  hg pull
#  hg update

# For unbuntu, sudo apt-get build-dep vim first!
# XXX : you should make distclean, if you need to reconfigure it after some libs are installed.
# Cleaning targets:
#  clean           - Remove most generated files but keep the config and
#                    enough build support to build external modules
#  mrproper        - Remove all generated files + config + various backup files
#  distclean       - mrproper + remove editor backup and patch files

# --disable-smack #Ubuntu10.04.4 does NOT support SMACK.
# gtk3 is NOT stable.
./configure \
    --enable-perlinterp=yes --enable-pythoninterp=yes --enable-python3interp=yes \
    --enable-rubyinterp=yes --enable-cscope --with-features=huge --enable-multibyte \
    --enable-gui=gtk2 --enable-xim

make
make install
