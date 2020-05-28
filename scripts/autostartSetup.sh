
cat <<EOM > /etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

# Print the IP address
#_IP=$(hostname -I) || true
#if [ "$_IP" ]; then
#  printf "My IP address is %s\n" "$_IP"
#fi
'/etc/automount.sh'
'/etc/autostart.sh'
exit 0

EOM

echo "" > /etc/autostart.sh
sudo chmod 755 /etc/autostart.sh
sudo touch /etc/automount.sh

echo "" > ./res/snapserver/2_streams
echo "" > /etc/asound.conf


echo "please setup the raspi wifi"
echo "you have to set your country for bluetooth to work"
echo "If you want to use bluetooth, you should connect your pi server with a lan cable"
echo
read -p "Choose Network Options -> Wireless Lan and follow the instructions" dump
sudo raspi-config
