#!/bin/bash
source options.conf

#echo
#echo -n "Do you want to install Snapclient v0.25.0? [y/N] "
#read REPLY
if [[ ! $sclient =~ ^(yes|y|Y)$ ]]; then exit 0; fi



wget https://github.com/badaix/snapcast/releases/download/v0.25.0/snapclient_0.25.0-1_armhf.deb
sudo dpkg -i snapclient_0.25.0-1_armhf.deb



echo "Updating dependencies and removing downloaded files"
sudo apt-get -f install --yes
sudo apt-get update
sudo apt-get -f install --yes
#sudo apt-get upgrade --yes
rm snapclient_0.25.0-1_armhf.deb

#################
#following needs testing
##############

#setup for server only
if [[ ! $server =~ ^(yes|y|Y)$ ]]; then exit 0; fi
#sudo systemctl disable snapclient.service
#echo "snapclient -s snapclient &" >> /etc/autostart.sh

cat <<EOM > /etc/default/snapclient
# Start the client, used only by the init.d script
START_SNAPCLIENT=true

# Additional command line options that will be passed to snapclient
# note that user/group should be configured in the init.d script or the systemd unit file
# For a list of available options, invoke "snapclient --help"
SNAPCLIENT_OPTS="-s snapclient"

EOM
