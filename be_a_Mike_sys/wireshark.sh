#!/bin/bash

sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt-get update
sudo apt install wireshark

sudo groupadd wireshark
sudo chgrp wireshark /usr/bin/dumpcap
sudo chmod 4755 /usr/bin/dumpcap
sudo gpasswd -a mike wireshark

