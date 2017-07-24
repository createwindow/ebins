#!/bin/bash

sudo apt-get install gcc-4.8 g++-4.8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8 
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5   60 --slave /usr/bin/g++ g++ /usr/bin/g++-5

