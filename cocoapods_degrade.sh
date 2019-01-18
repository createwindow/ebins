#!/bin/bash

echo "This script is used for degrading cocoapods to 1.5.0!"
sudo gem uninstall cocoapods
sudo gem uninstall cocoapods-core
sudo gem uninstall cocoapods-deintegrate
sudo gem uninstall cocoapods-downloader
sudo gem uninstall cocoapods-plugins
sudo gem uninstall cocoapods-search
sudo gem uninstall cocoapods-stats
sudo gem uninstall cocoapods-try
sudo gem uninstall cocoapods-trunk
sudo gem install -n /usr/local/bin --version 1.5.0 cocoapods
