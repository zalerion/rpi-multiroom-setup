#!/bin/bash
source options.conf

if [ $server == "no" ]
  then 
    exit 0;
fi
wget https://github.com/badaix/snapcast/releases/download/v0.25.0/snapserver_0.25.0-1_armhf.deb
sudo dpkg -i snapserver_0.25.0-1_armhf.deb

echo "Updating dependencies and removing downloaded files"

sudo apt-get -f install --yes
sudo apt-get update
sudo apt-get upgrade --yes
rm snapserver_0.25.0-1_armhf.deb


