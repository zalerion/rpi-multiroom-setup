#!/bin/bash

echo
echo -n "Do you want to install Snapclient v0.19.0? [y/N] "
read REPLY
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then exit 0; fi



wget https://github.com/badaix/snapcast/releases/download/v0.19.0/snapclient_0.19.0-1_armhf.deb
sudo dpkg -i snapclient_0.19.0-1_armhf.deb

rm snapclient_0.19.0-1_armhf.deb


#setup

sudo systemctl disable snapclient.service
echo "snapclient -s snapclient &" >> /etc/autostart.sh
cat <<EOM >> /etc/asound.conf
###############################################################################
#
#snapclient
        #
        pcm.snapclient
        {
                type plug;
                slave.pcm "sysdefault:0";
        }
###############################################################################
EOM

