#!/bin/bash

source options.conf

#snapclient="$1" 	# yes / no
#bluetooth="$2"	# yes / no
#dsp="$3"        # yes / no



cd res/asound


  if [ $dsp = "yes" ];then
    cat dsp >> /etc/asound.conf
  elif [ $sclient = "yes" ];then
    cat snapclient >> /etc/asound.conf    
  fi
  
  if [ $server = "yes" ];then
    if [ $btl = "yes" ];then
      cat bluetooth >> /etc/asound.conf
    fi
  fi
