#!/bin/bash
source options.conf

#btl="$1"     # yes / no

echo
if [[ ! $btl =~ (yes|y|Y) ]]; then exit 0; fi

cd rpi-audio-receiver-master
sudo ./install-bluetooth.sh
cd ..

echo
echo
echo
echo
echo
echo

echo "If there is a problem, please reboot first"
echo
echo
echo
echo
echo
echo
echo
echo
echo

sudo apt-get update > /dev/null
sudo apt-get install git automake build-essential libtool pkg-config python-docutils --yes 
sudo apt-get install libasound2-dev libbluetooth-dev libdbus-1-dev libglib2.0-dev libsbc-dev --yes 
sudo apt-get install cmake libavcodec-dev --yes
sudo apt-get install pandoc libncurses5-dev libbsd-dev libsndfile-dev doxygen --yes




git clone https://github.com/Arkq/openaptx.git
cd openaptx
git submodule update --init
mkdir build && cd build
cmake -DENABLE_DOC=ON -DWITH_FFMPEG=ON -DWITH_SNDFILE=ON ..
sudo make && sudo make install

cd ~

wget https://github.com/pali/libopenaptx/releases/download/0.2.1/libopenaptx-0.2.1.tar.gz
tar -xvf libopenaptx-0.2.1.tar.gz
cd libopenaptx-0.2.1
sudo make install




cd ~


git clone https://github.com/EHfive/ldacBT.git
cd ldacBT
git submodule update --init


sudo mkdir build && cd build
sudo cmake \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DINSTALL_LIBDIR=/usr/lib \
    -DLDAC_SOFT_FLOAT=OFF \
    ../
sudo make DESTDIR=$DEST_DIR install







cd ~

git clone https://github.com/Arkq/bluez-alsa.git
cd bluez-alsa
sudo autoreconf --install --force
mkdir build && cd build
../configure --enable-aptx --with-libopenaptx --enable-manpages --enable-ldac

sudo make
sudo make install
