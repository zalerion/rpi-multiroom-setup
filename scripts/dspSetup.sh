#!/bin/bash

source options.conf

if [ $dsp != yes ]; then exit 0; fi #dsp yes/no

######################### compiling yourself
#sudo apt-get update
#sudo apt-get install build-essential -y
#sudo apt-get install pkg-config -y 
sudo apt-get install ladspa-sdk -y
sudo apt-get install zam-plugins -y

#sudo apt-get install autoconf fftw3 fftw3-dev libzita-convolver3 libzita-convolver-dev libsndfile1 libsndfile1-dev libavcodec-dev libavformat-dev libasound2-dev libao-common libao-dev libmad0-dev -y

#sudo wget https://github.com/bmc0/dsp/archive/master.zip
#unzip master
#cd dsp-master

#make
#sudo make install

#cd ..
#rm -rf dsp-master
#rm -rf master.zip

#wget https://pilotfiber.dl.sourceforge.net/project/vlevel/vlevel/0.5/vlevel-0.5.tar.gz
#tar -xzf vlevel-0.5.tar.gz
#cd vlevel-0.5
#make
#sudo make install

#wget http://fftw.org/fftw-3.3.9.tar.gz
#tar -xzf fftw-3.3.9.tar.gz
#cd fftw-3.3.9/
#./configure --enable-float --enable-neon
#make 
#sudo make install

#sudo apt-get install gettext cvs autopoint perl libexpat1-dev libxml-parser-perl --yes

######## manually confirming necessary
#perl -MCPAN -e shell
#sudo cpan App::cpanminus
#sudo cpanm XML::Parser

#wget https://github.com/swh/ladspa/archive/refs/tags/v0.4.17.tar.gz
#tar -xzf v0.4.17.tar.gz
#cd ladspa-0.4.17/

#autoreconf -i
#./configure
#make
#sudo make install

#sudo cp /usr/local/lib/ladspa/* /usr/lib/ladspa/

sudo cp -r res/ladspa /usr/lib



#
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
