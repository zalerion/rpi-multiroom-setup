#!/bin/bash

source options.conf

if [ $dsp != yes ]; then exit 0; fi #dsp yes/no

######################### compiling yourself
sudo apt-get update
sudo apt-get install build-essential -y
sudo apt-get install pkg-config -y 
sudo apt-get install ladspa-sdk -y
sudo apt-get install zam-plugins -y

sudo apt-get install autoconf libtool fftw3 fftw3-dev libzita-convolver3 libzita-convolver-dev libsndfile1 libsndfile1-dev libavcodec-dev libavformat-dev libasound2-dev libao-common libao-dev libmad0-dev -y

#sudo wget https://github.com/bmc0/dsp/archive/master.zip
#unzip master
#cd dsp-master

#make
#sudo make install

#cd ..
#rm -rf dsp-master
#rm -rf master.zip

#wget https://github.com/radiocicletta/vlevel/archive/refs/tags/v0.5.tar.gz
#wget https://github.com/radiocicletta/vlevel/archive/refs/tags/v0.5.1.tar.gz
#tar -xzf vlevel-0.5.1.tar.gz
#cd vlevel-0.5.1
#make
#sudo make install

#wget http://fftw.org/fftw-3.3.9.tar.gz
#tar -xzf fftw-3.3.9.tar.gz
#cd fftw-3.3.9/
#./configure --enable-float --enable-neon
#make 
#sudo make install

#sudo apt-get install gettext cvs autopoint perl libexpat1-dev libxml-parser-perl --yes


#sudo apt-get install git automake build-essential pkg-config python-docutils --yes 
#sudo apt-get install libasound2-dev libbluetooth-dev libdbus-1-dev libglib2.0-dev libsbc-dev --yes 
#sudo apt-get install cmake libavcodec-dev --yes
#sudo apt-get install pandoc libncurses5-dev libbsd-dev libsndfile-dev doxygen --yes

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

# This demonstrates a split of left and right in high and low channels, compresses the bass, and recombines them. Adapt for own use. 
#remix 0 0 1 1
#:0,2 lowpass_1 100
#:1,3 highpass_1 120 gain -6
#:0,2 ladspa_host sc4_1882.so sc4 - 1.5 - -20 3 - - 
#remix 0,1 2,3

###############################
#reverse polarity:
#mult -1
# used e.g for recombining changed with original signal to hear only the difference

##########
#more extensive examples for inclúding aditional ladspa plugins
#ladspa_host  /usr/lib/ladspa/vlevel-ladspa.so vlevel_stereo 2 0.8 - 15 -
#ladspa_host filter lpf 1000


###########dynamic eq uses sidechain, which is not put out:
## dyneq (ZamDynamicEQ is cpu hungry. 4 instances on a PI 3 will not work
## Pseudo DynEQ is harder to tune an requires spectrum analyzer to check the actual effects. But this is less cpu heavy
#remix 0 1 0,1 0,1
#:0,2 @./dyneq.txt
#:1,2 @./dyneq.txt

#########################
#rough values to counteract tarwidth. Makes it possible to get effect for lower instead of higher volumes
#########################
#for tarwidth 1
#:- eq 1000 0.1o +10 

#for tarwidtdh 2
#:- eq 80 0.37o -10

#for tarwidtdh 3
#:- eq 1000 0.91o +10

#for tarwidtdh 4
#:- eq 1000 2.05o +10

#for tarwidtdh 5
#:- eq 1000 4o +10 

#:- lowshelf 8000 2.25o -10



# eq [Hz] [Q] [Gain] # parametric EQ
# 
#remix puts out:
#remix 0 1 #passthrough
#remix 0,1 0,1 #mixes both channels back, stereo to mono
#remix 1 0 #swaps channels
EOM




cat  <<EOM > /etc/ladspa_dsp/dyneq.txt
###################################################     Att     Rel     Knee    Ratio   Thresh  Max Boost/Cut   Slew    Sidechain       lowShelf        Peak    Highshelf(no function?) deFreq  tarFre  tarWidth        Boost(1)/Cut(0) ControlGain (not existing)
#ladspa_host ZamDynamicEQ-ladspa.so ZamDynamicEQ         15      500     2       2       -30     10              -       1               0               1       0                       1000      80      2               0

#################
#Pseudo Dyn EQ
#What happens:
#signal is doubled. one is eqed. get difference (only the eq). compress difference when louder..
# add compressed difference to original
# higher volume -> heavily compressed, less loud eq channel -> will get insignificant (like -30dB) and barely noticeable.
#
# note: funny things can happen 
#
# ratio and threshold have to be adapted to gain and bandwidth of the eq to get neutral at certain point.
# rule of thumb (at least for broader filters: threshold/ratio
#################

#####
# example of rough dynamic loudness equalization oriented at hearing curves for ~30dB difference
remix 0 1 0 1
#:2,3 eq 8000 0.9o 20

:2,3 highshelf 2000 0.7 15
:2,3 lowshelf 800 0.7 30
:2,3 mult -1
remix 0 1 0,2 1,3

:2,3 gain 0
# gain +x (+y)
:2,3 ladspa_host sc4_1882.so sc4 - 1.5 - -30 4 - -
:2,3 gain 0
# gain -x
# combination of those to gains can pull the "no eq" point down from max, giving an area at the top withou eq instead only max volume
:2,3 mult 1

remix 0,2 1,3

EOM
