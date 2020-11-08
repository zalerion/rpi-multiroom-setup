#!/bin/bash
if [ $1 = yes ]; then exit 0; fi #no mounting, if the setup is only as a client
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

if [[ ! "$go" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

echo "sudo mount -t cifs  $mount /mnt/share -o user=$user,password=$pwd,vers=1.0" > /etc/automount.sh
sudo chmod 755 /etc/automount.sh


if [ $2 = yes ]; then exit 0; fi #if mpd is installed, offer automated playlist backups
read -p "Would you like to set up an automated backup for your mpd playlists? They will be saved in your network share.[y/N] " go
if [[ ! "$go" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

sudo mkdir /mnt/share/Playlists
sudo crontab -l > tmpfile
sudo echo "5 0 * * * /etc/playlistBackup.sh" >> tmpfile
sudo crontab tmpfile
rm tmpfile

sudo cat  <<EOM > /etc/playlistBackup.sh
	sudo mkdir /mnt/share/Playlists/"Backup_Playlists_$(date +"%Y_%m_%d")"
	sudo cp /var/lib/mpd/playlists/* /mnt/share/Playlists/"Backup_Playlists_\$(date +"%Y_%m_%d")"
EOM
sudo chmod 755 /etc/playlistBackup.sh
