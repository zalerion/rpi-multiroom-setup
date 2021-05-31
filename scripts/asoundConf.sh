#!/bin/bash

source options.conf

#snapclient="$1" 	# yes / no
#bluetooth="$2"	# yes / no
#dsp="$3"        # yes / no
#$server        #yes / no snapserver


cd res/asound

  if [ $server = "yes" ];then
    if [ $btl = "yes" ];then
      cat bluetooth >> /etc/asound.conf
    fi
    if [ $sclient = "yes" ];then
      if [ $dsp = "yes" ];then
        cat dspSnapserver >> /etc/asound.conf
      else
        cat snapclient >> /etc/asound.conf  
      fi
    fi
  else
    if [ $dsp = "yes" ];then
      cat dsp >> /etc/asound.conf
    fi
  fi
  
