#!/bin/bash 

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

sudo rm /etc/asound.conf
#starting with clean asound.conf

server='no'
mpd=1
read -p "Do you want to setup the Pi as Snapserver [y/N] " REPLY
if [[ "$REPLY" =~ ^(yes|y|Y)$ ]]; 
then 
	server='yes'; 
	read -p "Do you want to stream from multiple MPD servers?  [y/N] " REPLY
	if [[ "$REPLY" =~ ^(yes|y|Y)$ ]]; then 
		 read -p "How many? [2-80] " REPLY
		mpd=$REPLY
		if [[ ( 1 < "$mpd" ) && "$mpd"  < 81 ]]; 
		then
			read -p "mkay"
		else
			if [[ 1 == "$mpd" ]]
			then
				echo "This are not multiple servers. This could have been easier for you!"
			else
				read -p "Nope! Try again! [OK, I'll learn to read]"
				exit 0;
			fi
		fi
	fi

fi

#echo " $((42-mpd))"

sudo chmod 755 snapclient.sh
sudo chmod 755 snapserver.sh
sudo chmod 755 snapfinish.sh
sudo chmod 755 mpd.sh
sudo chmod 755 mountnas.sh
sudo chmod 755 setTimeSync.sh
sudo chmod 755autostartSetup.sh

sudo ./autostartSetup.sh
sudo ./setTimeSync.sh
sudo ./snapserver.sh $server $mpd
sudo ./mpd.sh $server $mpd #also calls the mpdSetup
sudo ./snapclient.sh
sudo ./snapfinish.sh
sudo ./btlInstall.sh $server
sudo ./snapserverconf.sh $server
sudo ./mountnas.sh
