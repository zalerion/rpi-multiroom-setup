#!/bin/bash

if [[ ! "$1" =~ (yes|y|Y) ]]; then exit 0; fi
if [[ ! "$2" =~ (yes|y|Y) ]]; then exit 0; fi

echo "BTL SETUP"
echo "stream = pipe:///tmp/bluesnapfifo?name=BluetoothStream&sampleformat=44100:16:2" >> ./res/snapserver/2_streams
#rm tmp

cat <<EOM >> /etc/asound.conf
###########################################################################
#
#bluetooth comes in via default
pcm.!default {
   type plug
   slave.pcm rateConvert
}
#################
pcm.rateConvert {
    type rate
    slave {
        pcm writeFile # Direct to the plugin which will write to a file
        format S16_LE
        rate 44100
    }
}
###############
pcm.writeFile {
        type file
        slave.pcm null
        file "/tmp/bluesnapfifo"
        format "raw"
}
###############################################################################
EOM

