#!/bin/bash
echo "Updating dependencies and removing downloaded files"

sudo apt-get -f install --yes


sudo apt-get update
sudo apt-get upgrade --yes

sudo rm snapclient_0.19.0-1_armhf.deb
sudo rm	snapserver_0.19.0-1_armhf.deb

