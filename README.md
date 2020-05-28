# rpi-multiroom-setup
Simplify the extensive setup of a raspberry pi multiroom system. Based on Snapserver and mpd.


Please be aware: this is an early stage.

It is not fully tested!

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


### Planned

* setup hostname
* setup wifi
* setup a spotify speaker
* setup automatic reboot
* consolidated selections for faster / easier setup

