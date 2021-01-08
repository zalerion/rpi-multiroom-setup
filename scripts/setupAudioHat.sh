#!/bin/bash


if [[ ! "$1" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

cat  <<EOM > /boot/config.txt

# For more options and information see
# http://rpf.io/configtxt
# Some settings may impact device functionality. See link above for details

# uncomment if you get no picture on HDMI for a default "safe" mode
#hdmi_safe=1

# uncomment this if your display has a black border of unused pixels visible
# and your display can output without overscan
#disable_overscan=1

# uncomment the following to adjust overscan. Use positive numbers if console
# goes off screen, and negative if there is too much border
#overscan_left=16
#overscan_right=16
#overscan_top=16
#overscan_bottom=16

# uncomment to force a console size. By default it will be display's size minus
# overscan.
#framebuffer_width=1280
#framebuffer_height=720

# uncomment if hdmi display is not detected and composite is being output
#hdmi_force_hotplug=1

# uncomment to force a specific HDMI mode (this will force VGA)
#hdmi_group=1
#hdmi_mode=1

# uncomment to force a HDMI mode rather than DVI. This can make audio work in
# DMT (computer monitor) modes
#hdmi_drive=2

# uncomment to increase signal to HDMI, if you have interference, blanking, or
# no display
#config_hdmi_boost=4

# uncomment for composite PAL
#sdtv_mode=2

#uncomment to overclock the arm. 700 MHz is the default.
#arm_freq=800

# Uncomment some or all of these to enable the optional hardware interfaces
#dtparam=i2c_arm=on
#dtparam=i2s=on
#dtparam=spi=on

# Uncomment this to enable infrared communication.
#dtoverlay=gpio-ir,gpio_pin=17
#dtoverlay=gpio-ir-tx,gpio_pin=18

# Additional overlays and parameters are documented /boot/overlays/README

EOM


echo "Choose your Hat:"
echo
echo "[1] Hifiberry Miniamp, Hifiberry DAC"
echo "[2] Hifiberry Amp2"
echo "[3] IQAudio DAC+, DAC Pro"
echo "[4] DigiAMP+"
echo "[5] IQAudio Codec Zero"

echo
read -p "Please choose your hat [1/2/...]" REP

if [ $REP = "1" ];then
        cat  <<EOM >> /boot/config.txt
                dtoverlay=hifiberry-dac
EOM

elif [ $REP = "2" ];then
  cat  <<EOM >> /boot/config.txt
    dtoverlay=hifiberry-dacplus
EOM

elif [ $REP = "3" ];then
  cat  <<EOM >> /boot/config.txt
    dtoverlay=iqaudio-dacplus
EOM

elif [ $REP = "4" ];then
  cat  <<EOM >> /boot/config.txt
    dtoverlay=iqaudio-dacplus,unmute_amp
EOM

elif [ $REP = "5" ];then
  cat  <<EOM >> /boot/config.txt
    dtoverlay=iqaudio-codec
EOM

fi









cat  <<EOM >> /boot/config.txt

[pi4]
# Enable DRM VC4 V3D driver on top of the dispmanx display stack
dtoverlay=vc4-fkms-v3d
max_framebuffers=2

[all]
#dtoverlay=vc4-fkms-v3d

EOM
