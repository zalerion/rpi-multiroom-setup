#!/bin/bash

snapclient="$1" 	# yes / no
bluetooth="$2"	# yes / no
dsp="$3"        # yes / no



cd res/asound


  if [ $dsp = "yes" ];then
    cat dsp >> /etc/asound.conf
  elif [ $snapclient = "yes" ];then
    cat snapclient >> /etc/asound.conf    
  fi

  if [ $bluetooth = "yes" ];then
    cat bluetooth >> /etc/asound.conf
  fi
