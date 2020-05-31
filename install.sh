#!/bin/bash

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

#sudo rm /etc/asound.conf
##starting with clean asound.conf


server="no"
mpd="no"
sclient="no"
oclient="no"
btl="no"
####################################################################
#
#choices
#
####################################################################

echo "Choose your setup:"
echo
echo "[1] Only snapclient (select this option for a multiroom speaker)"
echo "[2] Audio server (select for local server or multiroom server setups) "
echo
read -p "Please choose this systems general purpose [1/2]" REP

if [ $REP = "1" ];then
	echo
	sclient="yes"
	oclient="yes"
elif [ $REP = "2" ];then
	echo

	read -p "Would you like to set up this pi as snapserver? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then server="yes"; fi

	read -p "Would you like to set up MPD? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then 
		mpd="yes";
		if [ $server = "yes" ];then
			read -p "How many MPD instances? [1-80] " REP
			mpd=$REP
		fi
	fi


	echo "Thanks to nico kaiser for providing his rpi-audio-receiver scripts!"
	read -p "Do you want to setup the bluetooth receiver? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then btl="yes"; fi



	read -p "Would you like to also use this pi as snapclient? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then sclient="yes"; fi

fi







#read -p "debug"


####################################################################
#
#installation
#
####################################################################

cd scripts

sudo chmod 755 autostartSetup.sh
sudo chmod 755 setTimeSync.sh
sudo chmod 755 snapserver.sh
sudo chmod 755 mpd.sh
sudo chmod 755 mpdSetup.sh
sudo chmod 755 snapclient.sh
sudo chmod 755 btlInstall.sh
sudo chmod 755 btlSetup.sh
sudo chmod 755 snapserverconf.sh
sudo chmod 755 mountnas.sh
cd rpi-audio-receiver-master
sudo chmod 755 hostnames.sh
sudo chmod 755 install-bluetooth.sh
sudo chmod 755 install-spotify.sh
sudo chmod 755 install-startup-sound.sh
cd ..

sudo ./autostartSetup.sh
sudo ./mountnas.sh $oclient
sudo ./snapserver.sh $server $mpd
sudo ./snapclient.sh $sclient

read -p "btl=$btl, server=$server"
sudo ./btlInstall.sh $btl
sudo ./btlSetup.sh $server $btl

sudo apt update
sudo apt upgrade --yes

sudo ./mpd.sh $server $mpd 
sudo ./mpdSetup.sh $server $mpd
sudo ./snapserverconf.sh $server
sudo ./setTimeSync.sh

echo
echo
read -p "The system will reboot now [Ok]"
sudo reboot
