# rpi-multiroom-setup
Simplify the extensive setup of a raspberry pi multiroom system. Based on Snapserver and mpd.


Please be aware: this is an early stage.

It is not fully tested!

Recommended with fresh install of raspbian buster lite.
Will overwrite/delete preexisting configurations for used modules, including (e.g.):
mpd.conf
snapserver.conf
asound.conf

How to use:
Just copy everything below into ssh session (e.g. putty with right click)
Then follow instructions in console.

> wget https://github.com/zalerion/rpi-multiroom-setup/archive/master.zip

> unzip master.zip

> rm master.zip 

> cd rpi-multiroom-setup-master

> sudo chmod 755 install.sh

> sudo ./install.sh



### Planned

* setup hostname
* setup wifi
