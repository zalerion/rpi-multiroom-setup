#!/bin/bash
if [ "$1" = "yes" ]; then 
echo "writing snapserver.conf"
cd ./res/snapserver 
echo "1"
cat 1 2_streams 3 > /etc/snapserver.conf 
echo /etc/snapserver.conf
fi


echo "snapserver configured"

