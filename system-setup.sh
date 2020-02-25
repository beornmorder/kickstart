#!/bin/bash

###CHECK FOR ROOT###
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

###SPOTIFY###
if [ -f /usr/bin/spotify ]; then
	echo "spotify already installed."
else
	curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	if [ -f /usr/bin/spotify ]; then
		echo "spotify installed successfully."
	else
		echo "error installing spotify"
	fi
fi

###TIMESHIFT###
if [ -f /usr/bin/timeshift ]; then
	echo "timeshift already installed."
else
	add-apt-repository -y ppa:teejee2008/timeshift
	apt-get update -y
	apt-get install -y timeshift
	if [ -f /usr/bin/timeshift ]; then
		echo "timeshift installed successfully."
	else
		echo "error installing timeshift."
	fi
fi

###CHROME###
if [ -f /usr/bin/google-chrome ]; then
		echo "chrome already installed"
	else
		wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
		apt-get update -y
		apt-get install -y google-chrome-stable
		if [ -f /usr/bin/google-chrome ]; then
			echo "chrome installed successfully"
		else
			echo "error installing chrome"
		fi
fi

###MEDIA-HUMAN###
if [ -f /opt/youtube-to-mp3/YouTubeToMP3  ]; then
	echo "media human already installed"
else
	add-apt-repository https://www.mediahuman.com/packages/ubuntu
	apt-key adv --keyserver pgp.mit.edu --recv-keys 7D19F1F3
	apt-get update -y
	apt-get install -y youtube-to-mp3
	if [ -f /opt/youtube-to-mp3/YouTubeToMP3 ]; then
		echo "media human installed successfully"
	else
		echo "error installing media human"
	fi
fi

packages=""

if [ ! -f /usr/bin/wget ]; then
	packages="wget "
fi

if [ ! -f /usr/bin/curl ]; then
	packages="curl " $packages
fi

if [ ! -f /usr/bin/locate ]; then
	packages="locate " $packages
fi

if [ ! -f /usr/bin/aria2c ]; then
	packages="aria2 " $packages
fi

if [ ! -d /var/www/html ]; then
	packages="apache2 " $packages
fi

if [ ! -d /usr/share/openssh ]; then
	packages="openssh-server openssh-client " $packages
fi

if [ ! -f /usr/bin/snap ]; then
	packages="snapd " $packages
fi

if [ ! -f /usr/bin/soundconverter ]; then
	packages="soundconverter " $packages
fi

if [ ! -f /usr/bin/pinta ]; then
	packages="pinta " $packages
fi

if [ ! -f /usr/bin/vlc ]; then
	packages="vlc " $packages
fi

if [ ! -f /usr/games/steam ]; then
	packages="steam " $packages
fi

if [ ! -f /usr/bin/gimp ]; then
	packages="gimp " $packages
fi

if [ ! -f /usr/bin/audacity ]; then
	packages="audacity " $packages
fi

if [ ! -f /usr/bin/neofetch ]; then
	packages="neofetch " $packages
fi

if [ ! -f /etc/minidlna.conf ]; then
	packages="minidlna " $packages
fi

if [ ! -f /usr/bin/deja-dup ]; then
	packages="deja-dup " $packages
fi

if [ ! -f /usr/bin/atom ]; then
	packages="atom " $packages
fi

if [ ! -f /usr/bin/virtualbox ]; then
	packages="virtualbox " $packages
fi

if [ ! -f /usr/sbin/gparted ]; then
	packages="gparted " $packages
fi

if [ ! -f /usr/bin/baobab ]; then
	packages="baobab " $packages
fi

if [ ! -f /usr/bin/uget-gtk ]; then
	packages="uget " $packages
fi

if [ ! -f /usr/share/app-install/desktop/gnome-tweak-tool:gnome-tweak-tool.desktop ]; then
	packages="gnome-tweak-tool " $packages
fi

if [ ! -f /usr/bin/libreoffice ]; then
	packages="libreoffice " $packages
fi

if [ ! -f /usr/bin/git ]; then
	packages="git " $packages
fi

if [ ! -f /usr/bin/transmission-gtk ]; then
	packages="transmission " $packages
fi

if [ ! -f /usr/sbin/arp-scan ]; then
	packages="arp-scan " $packages
fi

if [ "${#packages}" -gt "2" ];then
	apt-get install -y $packages
else
	echo "no new packages to install"
fi

if [ ! -d /lib/modules/5.3.0-7625-generic/updates/dkms/ ]; then
	git clone https://github.com/tomaspinho/rtl8821ce
	cd rtl8821ce/
	./dkms-install.sh
else
	echo "rtl8821ce already installed."
fi

#apt-get install -y  deja-dup atom virtualbox gparted baobab

###SET HOSTNAME###
machine_name=$(cat /etc/hostname)
if [ "$machine_name" = "alfavametraxis" ]; then
	echo "hostname already set to alfavametraxis"
else
	echo "alfavametraxis" > /etc/hostname
fi
