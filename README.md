# rpi-multiroom-setup
Simplify the extensive setup of a raspberry pi multiroom system. Based on Snapserver and mpd.


Tested with the 2020-05-27-raspios-buster-lite-armhf image and as full setup.
2020-08-20-raspios-buster-armhf-lite.img made some problems with bluetooth.
Add "sudo hciconfig hci0 reset" in autostart.sh


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

### Implemented
* Setup of mdp
* Setup as bluetooth receiver
* Setup of snapcast client and server
* Setup of time sync for use of multiple PI
* Setup for autostarting everything on boot
* Convenient option to mount a network share (fritz nas)


### Planned

* selection of audio output
* setup hostname
* setup wifi
* setup a spotify speaker [ongoing]
* setup automatic reboot
* add choices for samplerate
* add choice for mopidy instead of mpd
