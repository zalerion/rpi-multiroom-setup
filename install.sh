#!/bin/bash

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

sudo chmod 755 setRights.sh
sudo ./setRights.sh


sudo ./setOptions.sh


##################
#calling actual install and config scripts
##################
pwd
sudo ./callScripts.sh


echo
echo
read -p "The system will reboot now [Ok]"
sudo reboot
