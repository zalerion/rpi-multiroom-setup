#!/bin/bash

if [ $dsp == no ]; then exit 0; fi #dsp yes/no

sudo apt-get update
sudo apt-get install build-essential -y
sudo apt-get install pkg-config -y 
#sudo apt install git-all -y
sudo apt-get install ladspa-sdk -y

sudo wget https://github.com/bmc0/dsp/archive/master.zip
unzip master
cd dsp-master

################git clone https://github.com/bmc0/dsp.git
################cd dsp

make
sudo make install

cd ..
rm -rf dsp-master
rm -rf master.zip

sudo mkdir /etc/ladspa_dsp
#sudo nano /etc/ladspa_dsp/config

cat  <<EOM > /etc/ladspa_dsp/config
input_channels=2
################ To not be mono
output_channels=2
################ Important for Remix to output correctly
effects_chain= @./eq.txt
################ Contains all the acutal eq definitions
EOM

cat  <<EOM > /etc/ladspa_dsp/eq.txt
remix 0 0	1 1	
# 0 is left, 1 is right
:0,2 lowpass 1000 0.7	
# "left" output
:1,3 highpass 1000 0.7	
# "right" output
remix 0,1 2,3 
#mixes both channels back


# This demonstrates a split of left and right in high and low channels, filters them, and recombines them. In Sum in=out
#remix puts out:
#remix 0 1 #passthrough
#remix 0,1 0,1 #mixes both channels back
#remix 1 0 #swaps channels
EOM
