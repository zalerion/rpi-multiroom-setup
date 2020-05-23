#!/bin/bash -e

echo
echo "Mount a network share. Tested for fritz box nas. If it is not working, you have to do it manually."
read -p "This is possibly wonky. Do you want to try it anyways? (y/N)" go

if [[ ! "$go" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

sudo su
sudo mkdir /mnt/share
read -p "Enter //IP/Mountpoint (Example : //192.168.1.1/fritznas) :" mount
read -p "Enter username:" user
read -s -p "Enter Password:" pwd

echo
sudo mount -t cifs  $mount /mnt/share -o user=$user,password=$pwd,vers=1.0
su pi