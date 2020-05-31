#!/bin/bash

#btl="$1"     # yes / no

echo
if [[ ! "$1" =~ (yes|y|Y) ]]; then exit 0; fi

cd rpi-audio-receiver-master
sudo ./install-bluetooth.sh
cd ..
