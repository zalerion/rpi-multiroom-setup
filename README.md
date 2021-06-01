# 5.10 Kernel apparently broken https://github.com/badaix/snapcast/issues/815 - dsp unusable for some sources
will be testing for last functioning version
2021-01-11-raspios-buster-armhf-lite has no obvious problems

# rpi-multiroom-setup
Started as multiroom project. Became more of an general purpose audio setup.
Simplifies the extensive setup of a raspberry pi for audio use. Includes mobile speaker multiroom system and music server. 




Tested with the 2020-05-27-raspios-buster-lite-armhf image and as full setup.
2020-08-20-raspios-buster-armhf-lite.img made some problems with bluetooth.
<s>Add "sudo hciconfig hci0 reset" in autostart.sh</s> should work now


Recommended with fresh install of raspbian buster lite.
Will overwrite/delete preexisting configurations for used modules, including (e.g.):
mpd.conf,
snapserver.conf,
asound.conf

How to use:
Just copy everything below into ssh session (e.g. putty with right click)
Then follow instructions in console.

> sudo wget https://github.com/zalerion/rpi-multiroom-setup/archive/master.zip

> sudo unzip master.zip

> sudo rm master.zip 

> cd rpi-multiroom-setup-master

> sudo chmod 755 install.sh

> sudo ./install.sh


## Used software and scripts to make this possible:

https://github.com/badaix/snapcast

https://github.com/MusicPlayerDaemon/MPD

https://github.com/nicokaiser/rpi-audio-receiver

https://github.com/dtcooper/raspotify

https://github.com/bmc0/dsp

https://github.com/Arkq/bluez-alsa + dependencies

### Implemented
* Setup of mdp
* Setup as bluetooth receiver (including AAC and aptX)
* Setup of snapcast client and server
* Setup of time sync for use of multiple PI
* Setup for autostarting everything on boot
* Convenient option to mount a network share (fritz nas)
* Setup a spotify speaker
* Setup for Hats: DAC and amps
* for multiroom speakers: dsp e.g for active 2-way speaker

### Planned
* testing/setting up new ALSA audio grab for snapserver.
* rounting BT not through default...
* selection of audio output (a hat will be selected, but HDMI/Headphones might be problematic)
* better defaults for hdmi
* setup hostname
* setup wifi
* setup automatic reboot
* add choices for samplerate
* add choice for mopidy instead of mpd



# Konwn issues
Not all setups will work on every Pi out of the box.
Pi 3 should be straightforward.
Pi 4 might need adjustments. Specifivally for the local audio output via hdmi changes in sudo raspi-conf, /boot/config.txt and /etc/asound.conf might be needed.

Some setups have had problems with 48000Hz samplerate, it seems to be better with the updated RaspiOS. If you have audio dropouts, try changing the samplerates to 44100Hz.
