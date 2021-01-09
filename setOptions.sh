#!/bin/bash

export server="no"	#setup as server yes/no
export mpd="no"	#setup mpd yes/no
export sclient="no" 	#setup of snapclient yes/no
export oclient="no" 	#option for "only only as client" setup
export btl="no"	##setup the bluetooth receiver yes/no
export spotify="no"	#setup spotify yes/no
export dsp="no"
export hat="no"	# setup for hifiberry etc.

echo "Choose your setup:"
echo
echo "[1] Only snapclient (select this option for a multiroom speaker)"
echo "[2] Audio server (select for local server/receiver or multiroom server setups) "
echo
read -p "Please choose this systems general purpose [1/2]" REP

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
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then btl="yes"; fi



	read -p "Would you like to also use this pi as snapclient? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then sclient="yes"; fi

fi

	read -p "Would you like to set up a dsp? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then dsp="yes"; fi
	
	read -p "Would you like to set use an Audio-Hat? [y/N] " REP
	if [[ $REP =~ ^(yes|y|Y)$ ]]; then hat="yes"; fi
