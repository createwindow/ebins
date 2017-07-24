#!/bin/bash

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg -i --force-depends google-chrome-stable_current_amd64.deb

# In case any dependencies diddnt install (you would have a warning or failure message for 
# this), you can force them via:
# sudo apt-get install -f

