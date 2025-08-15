#!/bin/sh

echo "Copy new file"

sudo cp ./dts/newracom.dtbo /boot/overlays/
sudo chmod +x ./nrc/cli_app
sudo cp ./nrc/cli_app /usr/sbin/
sudo cp ./nrc/nrc.ko  /lib/modules/$(uname -r)/
sudo cp ./nrc/nrc7292_bd.dat /lib/firmware/
sudo cp ./nrc/nrc7292_cspi.bin /lib/firmware/

echo "Set config"

count=$(cat /boot/config.txt | grep -c "dtoverlay=disable-bt")
[ $count = "0" ] && {
	sudo echo "dtoverlay=disable-bt" >> /boot/config.txt
}

count=$(cat /boot/config.txt | grep -c "dtoverlay=disable-wifi")
[ $count = "0" ] && {
	sudo echo "dtoverlay=disable-wifi" >> /boot/config.txt
}

count=$(cat /boot/config.txt | grep -c "dtoverlay=disable-spidev")
[ $count = "0" ] && {
	sudo echo "dtoverlay=disable-spidev" >> /boot/config.txt
}

count=$(cat /etc/modules | grep -c "mac80211")
[ $count = "0" ] && {
	sudo echo "mac80211" >> /etc/modules
}

count=$(cat /etc/modprobe.d/elastpro-blacklist.conf | grep -c "blacklist brcmfmac")
[ $count = "0" ] && {
	sudo echo "brcmfmac" >> /etc/modprobe.d/raspi-blacklist.conf
}

count=$(cat /etc/modprobe.d/elastpro-blacklist.conf | grep -c "blacklist brcmutil")
[ $count = "0" ] && {
	sudo echo "brcmutil" >> /etc/modprobe.d/raspi-blacklist.conf
}

echo "Complete"
