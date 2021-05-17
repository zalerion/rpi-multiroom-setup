#!/bin/bash

server="no"	#setup as server yes/no
mpd="no"	#setup mpd yes/no
sclient="no" 	#setup of snapclient yes/no
oclient="no" 	#option for "only only as client" setup
btl="no"	##setup the bluetooth receiver yes/no
btlADC="no"	#Advanced
spotify="no"	#setup spotify yes/no
dsp="no"
hat="no"	# setup for hifiberry etc.

echo "Choose your setup:"
echo
echo "[1] Multiroom Speaker (snapclient, dsp and hats)"
echo "[2] Audio Server (select for local server/receiver or multiroom server setups. All options are available here) "
echo "[3] Mobile Box (just bluetooth, dsp and hats)"
echo
read -p "Please choose this systems general purpose [1/2/3]" REP

if [ $REP = "1" ];then
	echo
	sclient="yes"
	oclient="yes"
elif [ $REP = "2" ];then
	echo

	read -p "Would you like to set up this pi as snapserver? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then server="yes"; 
		################
		#spotify "without snapserver" not configured yet.
		################
		echo
		echo "Thanks to dtcooper for his easy raspotify setup!"
		read -p "Do you want to setup as spotify connect speaker? [y/N] " REP
		if [[ $REP =~ ^(yes|y|Y)$ ]]; then spotify="yes"; fi

	fi
	echo
	read -p "Would you like to set up MPD? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then 
		mpd="yes";
		if [ $server = "yes" ];then
			read -p "How many MPD instances? [1-80] " REP
			mpd=$REP
		fi		
	fi
	
	
	echo
	echo "Thanks to nico kaiser for providing his rpi-audio-receiver scripts!"
	read -p "Do you want to setup the bluetooth receiver? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then btl="yes"; 
		read -p "Would you like codec support aptX? NOTE: This will take significantly longer to install! [y/N] " REP
		if [[ $REP =~ ^(yes|y|Y)$ ]]; then btlADV="yes"; fi
	fi


	read -p "Would you like to also use this pi as snapclient? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then sclient="yes"; fi


elif [ $REP = "3" ];then
	btl="yes"
	read -p "Would you like codec support aptX? NOTE: This will take significantly longer to install! [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then btlADV="yes"; fi
fi

	

	read -p "Would you like to set up a dsp? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then dsp="yes"; fi
	
	read -p "Would you like to set use an Audio-Hat? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then hat="yes"; fi

cat <<EOM > scripts/options.conf
server=$server	#setup as server yes/no
mpd=$mpd	#setup mpd yes/no
sclient=$sclient 	#setup of snapclient yes/no
oclient=$oclient 	#option for "only only as client" setup
btl=$btl	##setup the bluetooth receiver yes/no
spotify=$spotify	#setup spotify yes/no
dsp=$dsp
hat=$hat	# setup for hifiberry etc.
EOM
