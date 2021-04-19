#!/bin/bash
source options.conf

#btl="$1"     # yes / no

echo
if [[ ! $btl =~ (yes|y|Y) ]]; then exit 0; fi

cd rpi-audio-receiver-master
sudo ./install-bluetooth.sh
cd ..
