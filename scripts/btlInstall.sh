#!/bin/bash

#server="$1"     # yes / no

echo
#echo "Thanks to nico kaiser for providing his rpi-audio-receiver scripts!"
#read -p "Do you want to setup the bluetooth receiver? [y/N] " REPLY

if [[ ! $2  =~ ^(yes|y|Y)$ ]]; then exit 0; fi
if [[ ! $1  =~ ^(yes|y|Y)$ ]]; then exit 0; fi


#wget -q https://github.com/nicokaiser/rpi-audio-receiver/archive/master.zip
#unzip master.zip
#rm master.zip

cd rpi-audio-receiver-master
sudo ./install-bluetooth.sh

cd ..
#rm -r rpi-audio-receiver-master

#if [ $server = "yes" ]; then
#sudo ./btlSetup.sh
#fi


