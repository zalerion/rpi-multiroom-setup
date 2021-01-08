#!/bin/bash

#echo
#echo -n "Do you want to install Snapclient v0.22.0? [y/N] "
#read REPLY
if [[ ! "$1" =~ ^(yes|y|Y)$ ]]; then exit 0; fi



wget https://github.com/badaix/snapcast/releases/download/v0.22.0/snapclient_0.22.0-1_armhf.deb
sudo dpkg -i snapclient_0.22.0-1_armhf.deb



echo "Updating dependencies and removing downloaded files"
sudo apt-get -f install --yes
sudo apt-get update
sudo apt-get upgrade --yes
rm snapclient_0.22.0-1_armhf.deb


#setup for server only
if [[ "$2" =~ ^(yes|y|Y)$ ]]; then exit 0; fi
sudo systemctl disable snapclient.service
echo "snapclient -s snapclient &" >> /etc/autostart.sh
#cat <<EOM >> /etc/asound.conf
################################################################################
##
##snapclient
#        #
#        pcm.snapclient
#        {
#                type plug;
#                slave.pcm "sysdefault:0";
#        }
################################################################################
#EOM

