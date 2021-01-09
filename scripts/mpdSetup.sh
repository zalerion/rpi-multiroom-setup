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
echo "Replay gain is recommended for general background music. Do not use for classical. Will be set for all MPD servers. You can easily configure this later by hand."
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

sudo mkdir /var/lib/mpd/playlists
cp ./res/Radio.m3u /var/lib/mpd/playlists

########################################################
#individual setup

#######
#needed later for orientation
echo 

if [ "$server" = "yes" ]; then

	echo "Each stream has a name that will show up in the snapcast control"
        for i in `seq 0 "$(($mpd-1))"`;
        do
		read -p "Please enter the name for stream Number $i:" name
		echo "stream = pipe:///tmp/fifo$i?name=$name&mode=read&sampleformat=44100:16:2" >> ./res/snapserver/2_streams
#######################################
		cat  <<EOM > ./res/mpd/6_fifo
	name            "$name"
	path            "/tmp/fifo$i"
EOM
########################################
		echo "port                            \"$((6600+$i))\"" > ./res/mpd/4_port
		echo "state_file                     \"/var/lib/mpd/state$i\"" > ./res/mpd/2_state

# put specified mpd in autostart
		path="/etc/mpd$i.conf" #path to new mpdX.conf file
		cd ./res/mpd
		cat 1 2_state 3 4_port 5 6_fifo 7 8_rpgain 9 > $path
		echo "sudo mpd $path" >> /etc/autostart.sh
		cd ..
		cd ..
        done

#cleanup
fi

if [ $mpd = "1" ]; then 
	read -p "Your MPD server uses the standard port of 6600 [OK/OK]" dump
else
	read -p "Ports range from 6600 to $((6600-1+$mpd)) [OK/OK]" dump
fi

