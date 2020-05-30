#!/bin/bash

if [[ "$1" == "yes" ]]
  then
    echo
    echo "You have selected the setup as a Snapserver."
    if [[ "$2" == "1" ]] 
    then
	echo
#	echo "Only one MPD was selected."
#	echo "MPD will be set up as service and play to the snapserver."
#	read -p "You will have to configure your MPD client of choice to the standard port 6600. [OK/OK] " dump
    else
	echo
#      echo "MPD will not be started as service but via commands in rc.local."
#      echo "Each MPD gets its own port which you will have to enter in your MPD client of choice."
#      read -p "Ports range from 6600 to $((6600-1+$2)) [OK/OK]" dump
    fi
else
	exit 0;
 #     read -p "Do you want to install the MPD server? [y/N] " REPLY
 #   if [[ ! $REPLY =~ (yes|y|Y) ]]; then exit 0; fi
 #   echo
 #   read -p "You have selected MPD setup without Snapserver. MPD will be set up as service and play via alsa directly to the default output. You will have to configure your MPD client of choice to the standard port 6600. [OK/OK] " dump
fi
#read -p "install mpd"
sudo apt-get install mpd --yes
#read -p "mpd installed"


if [[ ! "$2" == "1" ]]; then
  sudo systemctl stop mpd
  sudo systemctl disable mpd
fi

#echo "Setting up your MPD servers now"

#sudo ./mpdSetup.sh $1 $2

