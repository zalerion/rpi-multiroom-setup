#!/bin/bash

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

#sudo rm /etc/asound.conf
##starting with clean asound.conf


#server="no"	#setup as server yes/no
#mpd="no"	#setup mpd yes/no
#sclient="no" 	#setup of snapclient yes/no
#oclient="no" 	#option for "only only as client" setup
#btl="no"	##setup the bluetooth receiver yes/no
#spotify="no"	#setup spotify yes/no
#dsp="no"
#hat="no"	################################################################# setup for hifiberry etc.
####################################################################
#
#choices
#
####################################################################

#echo "Choose your setup:"
#echo
#echo "[1] Only snapclient (select this option for a multiroom speaker)"
#echo "[2] Audio server (select for local server/receiver or multiroom server setups) "
#echo
#read -p "Please choose this systems general purpose [1/2]" REP

#if [ $REP = "1" ];then
#	echo
#	sclient="yes"
#	oclient="yes"
#elif [ $REP = "2" ];then
#	echo
#
#	read -p "Would you like to set up this pi as snapserver? [y/N] " REP
#	if [[ $REP =~ ^(yes|y|Y)$ ]]; then server="yes"; 
#		################
#		#spotify "without snapserver" not configured yet.
#		################
#		echo
#		echo "Thanks to dtcooper for his easy raspotify setup!"
#		read -p "Do you want to setup as spotify connect speaker? [y/N] " REP
#		if [[ $REP =~ ^(yes|y|Y)$ ]]; then spotify="yes"; fi
#
#	fi
#	echo
#	read -p "Would you like to set up MPD? [y/N] " REP
#	if [[ $REP =~ ^(yes|y|Y)$ ]]; then 
#		mpd="yes";
#		if [ $server = "yes" ];then
#			read -p "How many MPD instances? [1-80] " REP
#			mpd=$REP
#		fi		
#	fi
#	
#	
#	echo
#	echo "Thanks to nico kaiser for providing his rpi-audio-receiver scripts!"
#	read -p "Do you want to setup the bluetooth receiver? [y/N] " REP
#	if [[ $REP =~ ^(yes|y|Y)$ ]]; then btl="yes"; fi
#
#
#
#	read -p "Would you like to also use this pi as snapclient? [y/N] " REP
#	if [[ $REP =~ ^(yes|y|Y)$ ]]; then sclient="yes"; fi
#
#fi
#
#	read -p "Would you like to set up a dsp? [y/N] " REP
#	if [[ $REP =~ ^(yes|y|Y)$ ]]; then dsp="yes"; fi
#	
#	read -p "Would you like to set use an Audio-Hat? [y/N] " REP
#	if [[ $REP =~ ^(yes|y|Y)$ ]]; then hat="yes"; fi
#
#
#


#read -p "debug"


####################################################################
#
#installation
#
####################################################################


##################
#rights
##################

sudo chmod 755 setRights.sh
sudo ./setRights.sh


sudo ./setOptions.sh
#cd scripts

#sudo chmod 755 autostartSetup.sh
#sudo chmod 755 setTimeSync.sh
#sudo chmod 755 snapserver.sh
#sudo chmod 755 mpd.sh
#sudo chmod 755 mpdSetup.sh
#sudo chmod 755 snapclient.sh
#sudo chmod 755 btlInstall.sh
#sudo chmod 755 btlSetup.sh
#sudo chmod 755 snapserverconf.sh
#sudo chmod 755 mountnas.sh
#sudo chmod 755 spotifyConnectInstall.sh
#sudo chmod 755 asoundConf.sh
#sudo chmod 755 setupAudioHat.sh
#sudo chmod 755 dspSetup.sh

#cd rpi-audio-receiver-master
#sudo chmod 755 hostnames.sh
#sudo chmod 755 install-bluetooth.sh
#sudo chmod 755 install-startup-sound.sh
#cd ..


##################
#calling actual install and config scripts
##################
pwd
sudo ./callScripts.sh

echo
echo
read -p "The system will reboot now [Ok]"
sudo reboot
