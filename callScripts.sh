cd scripts

sudo ./setupAudioHat.sh $hat

sudo ./autostartSetup.sh
sudo ./mountnas.sh $oclient $mpd
sudo ./mpdSetup.sh $server $mpd

sudo ./dspSetup.sh $dsp

sudo ./spotifyConnectInstall.sh $server $spotify
sudo ./snapserver.sh $server $mpd
sudo ./snapclient.sh $sclient $oclient

#read -p "btl=$btl, server=$server"
sudo ./btlInstall.sh $btl
sudo ./btlSetup.sh $server $btl

#sudo apt update
#sudo apt upgrade --yes

sudo ./mpd.sh $server $mpd 
sudo ./snapserverconf.sh $server
sudo ./setTimeSync.sh
sudo ./asoundConf.sh $sclient $btl $dsp
