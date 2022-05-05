# Bluetooth is broken

everything shiny and new and broken.
Got no time to fix it :(

https://github.com/Daenou/ansible-multiroom-audio/issues/18

HDMI doesn't show up in Bullseye, Buster legacy seems to work better.
https://www.reddit.com/r/raspberry_pi/comments/qujijj/no_hdmi_audio_in_raspiconfig_raspberry_os_lite/

Buster packages are not up to date:
https://raspberrytips.com/update-raspberry-pi-latest-version/


# rpi-multiroom-setup
Started as multiroom project. Became more of an general purpose audio setup.
Simplifies the extensive setup of a raspberry pi for audio use. Includes mobile speaker multiroom system and music server. 



Everything is done rather lightweight, straightforward and modular. Only uses ALSA, no pulse, no jack or anything. Even with a full install, I think i never saw anything >4GB, so any modern SD Card will suffice, as will most older ones.
DSP is done with ladspa and is directly hosted in ALSA, so it will be applied, no matter what the source.
Any additional player can easily be added as multiroom source.



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

http://plugin.org.uk/ladspa-swh/docs/ladspa-swh.html

http://www.zamaudio.com/?p=976

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
* dsp with dynamic eq
* testing/setting up new ALSA audio grab for snapserver.
* services instead of daemons

### Planned
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
