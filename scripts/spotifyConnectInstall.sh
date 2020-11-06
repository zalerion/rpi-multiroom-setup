#!/bin/bash
server="$1"   # server yes/no
spotify="$2"	# install spotify speaker yes/no

if [ $spotify = "no" ];then exit 0; fi

#   uses the quick setup dtcooper
#   https://github.com/dtcooper/raspotify
curl -sL https://dtcooper.github.io/raspotify/install.sh | sh


#   we will start it seperatley directly with snapserver -> disable service
sudo systemctl disable raspotify.service


#   writing the spotify stream to snapserver

if [ "$server" = "yes" ]; then
		echo "stream = spotify:///librespot?name=Spotify&bitrate=320" >> ./res/snapserver/2_streams
else
  # eventual setup of spotify connect without stream
  # to be implemented
  echo
fi
