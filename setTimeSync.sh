#!/bin/bash
zones="/usr/share/zoneinfo/"

echo 
echo "It is recommended to activate time sync."
read -p "Do you want to activate time sync? [y/N] " REPLY
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

while :
do
	echo
	ls $zones
	echo
	read -p "Please choose your zone/country/continent: " s1

	if [ ! -f "$zones$s1" ] && [ ! -d "$zones$s1" ]; then
		read -p "Your input is not in the list, please try again [Enter]" dump
	else
		break
	fi
done

if [ -d "$zones$s1" ]; then
	while :
	do
		s1="$s1/"
		ls $zones$s1
		read -p "Please select your zone: " s2
		if [ ! -f "$zones$s1$s2" ]; then
	                read -p "Your input is not in the list, please try again [Enter]" dump
		else
			break
		fi
	done
fi
cp "$zones$s1$s2" /etc/localtime


sed -i -e "s/#NTP.*/NTP=0.ro.pool.ntp.org 1.ro.pool.ntp.org/" /etc/systemd/timesyncd.conf
sed -i -e "s/#FallbackNTP.*/FallbackNTP=ntp.ubuntu.com 0.arch.pool.ntp.org/" /etc/systemd/timesyncd.conf


sudo timedatectl set-ntp true 

echo
echo "This should be your time: " 
date
read -p "[y/N] " REPLY
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then 
echo "Please try some other method!"
fi

