#!/bin/bash

server="$1"     # yes / no


read -p "Do you want to setup the bluetooth receiver? This will use the rpi-audio-receiver script by nico kaiser [y/N] " REPLY
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then exit 0; fi


wget -q https://github.com/nicokaiser/rpi-audio-receiver/archive/master.zip
unzip master.zip
rm master.zip

cd rpi-audio-receiver-master
sudo ./install-bluetooth.sh

echo "1"
cd ..
echo "2"
rm -r rpi-audio-receiver-master
echo "3"
if [ $server = "yes" ]; then
sudo ./btlSetup.sh
fi
