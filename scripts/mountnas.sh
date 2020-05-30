#!/bin/bash
echo
echo "Mount a network share. Tested for fritz box nas. If it is not working, you have to do it manually."
read -p "This is possibly wonky. Do you want to try it anyways? (y/N)" go

if [[ ! "$go" =~ ^(yes|y|Y)$ ]]; then exit 0; fi


sudo mkdir /mnt/share
read -p "Enter //IP/Mountpoint (Example : //192.168.1.1/fritznas) :" mount
read -p "Enter username:" user
read -s -p "Enter nas password:" pwd

echo
sudo mount -t cifs  $mount /mnt/share -o user=$user,password=$pwd,vers=1.0


read -p "Want to make it permanent? Please be aware, that your password will be saved in plaintext (y/N)" go

echo "sudo mount -t cifs  $mount /mnt/share -o user=$user,password=$pwd,vers=1.0" > /etc/automount.sh
sudo chmod 755 /etc/automount.sh

if [[ ! "$go" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

