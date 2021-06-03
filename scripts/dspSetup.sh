#!/bin/bash

source options.conf

if [ $dsp != yes ]; then exit 0; fi #dsp yes/no

sudo apt-get update
sudo apt-get install build-essential -y
sudo apt-get install pkg-config -y 
#sudo apt install git-all -y
sudo apt-get install ladspa-sdk -y

sudo wget https://github.com/bmc0/dsp/archive/master.zip
unzip master
cd dsp-master

make
sudo make install

cd ..
rm -rf dsp-master
rm -rf master.zip




################git clone https://github.com/bmc0/dsp.git
################cd dsp

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

# This demonstrates a split of left and right in high and low channels, compresses the bass, and recombines them. Adapt for own use. (very basic setuop for multiband compression or adapted simulation of dynamic eqs

#remix 0 0 1 1
#:0,2 lowpass_1 100
#:1,3 highpass_1 120 gain -6
#:0,2 ladspa_host sc4_1882.so sc4 - 1.5 - -20 3 - -  ######### compression
#remix 0,1 2,3

###############################
#reverse polarity:
#mult -1
# used e.g for recombining changed with original signal to hear only the difference

##########
#more extensive examples for inclúding aditional ladspa plugins
#ladspa_host  /usr/lib/ladspa/vlevel-ladspa.so vlevel_stereo 2 0.8 - 15 -
#ladspa_host filter lpf 1000
#:0,2 ladspa_host lsp-plugins-ladspa http://lsp-plug.in/plugins/ladspa/mb_compressor_stereo 0 1 ####missing lots of parameters


# eq [Hz] [Q] [Gain] # parametric EQ
# 
#remix puts out:
#remix 0 1 #passthrough
#remix 0,1 0,1 #mixes both channels back, stereo to mono
#remix 1 0 #swaps channels
EOM
