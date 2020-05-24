#!/bin/bash
if [ "$1" = "yes" ]; then 
	echo "writing snapserver.conf"
	cd ./res/snapserver 
	cat 1 2_streams 3 > /etc/snapserver.conf 
	echo "snapserver configured"
fi



