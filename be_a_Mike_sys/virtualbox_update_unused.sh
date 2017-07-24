#!/bin/bash

echo "deb http://download.virtualbox.org/virtualbox/debian xenial contrib" >> /etc/apt/sources.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt-get update
#sudo apt-get install dkms # optional
#sudo apt-get install virtualbox-5.1

