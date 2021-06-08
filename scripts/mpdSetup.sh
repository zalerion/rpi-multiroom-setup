#!/bin/bash
source options.conf

#server="$1" 	# yes / no
#mpd="$2"	# number mpd servers
echo $mpd
if [ $mpd == "no" ];then exit 0; fi

echo "Basic setup for mpd: library in /mnt/share. All rights without password."
read -p "Change later if needed. [OK/Enter]" dump


# set paths, unloch bind to addrss, activate non default port, set permissions

echo
echo "Replay gain is recommended for general background music. Do not use for classical. Will be set for all MPD servers. You can easily configure this later by hand. Generell recommendation: album"
echo
echo "Please note: You will have to have the files tagged before replay gain takes effect. This can be done e.g with foobar."
echo
read -p "Do you want to use replay gain by track, by album or not at all? [track/album/No] " REPLY
if [[ "$REPLY" =~ ^(track|album)$ ]];
then
	echo "replaygain                      \"$REPLY\"" > ./res/mpd/8_rpgain
else
        echo "#replaygain                      \"no\"" > ./res/mpd/8_rpgain
fi



########################################################
#individual setup

#######
#needed later for orientation
echo 



if [ "$server" = "yes" ]; then
	#locale single mpd instance can use standard config. For server special config is needed.
	sudo systemctl stop mpd
	sudo systemctl disable mpd
	

	echo "Each stream has a name that will show up in the snapcast control"
	cd ./res/mpd
        for i in `seq 1 "$(($mpd))"`;
        do
		read -p "Please enter the name for stream Number $i:" name
		
		echo "stream = pipe:///tmp/fifo$i?name=$name&mode=read" >> ./res/snapserver/2_streams
#######################################
		cat  <<EOM > 6_fifo
	name            "$name"
	path            "/tmp/fifo$i"
EOM
########################################
		echo "port                            \"$((6600+$i))\"" > ./res/mpd/4_port
		echo "state_file                     \"/var/lib/mpd/state$i\"" > ./res/mpd/2_state

# put specified mpd in autostart
		path="/etc/mpd$i.conf" #path to new mpdX.conf file
		
		cat 1 2_state 3 4_port 5 6_fifo 7 8_rpgain 9 > $path

# older daemons. now services
#		echo "sudo mpd $path" >> /etc/autostart.sh

		echo "ExecStart=/usr/bin/mpd --no-daemon $path" > service_2
		
		servicepath="/lib/systemd/system/mpd$i.service"
		cat service_1 service_2 service_3 > $servicepath
		
		sudo systemctl enable mpd$i

        done

	cd ..
	cd ..
#cleanup
fi

if [ $mpd = "1" ]; then 
	read -p "Your MPD server uses the standard port of 6600 [OK/OK]" dump
else
	read -p "Ports range from 6601 to $((6601-1+$mpd)) [OK/OK]" dump
fi

