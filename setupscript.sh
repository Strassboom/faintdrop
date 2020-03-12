#!/bin/bash
LIVE=leopold
host=$(hostname)
if [ $host != $LIVE ]
then
        echo "This server is not initialized"
	echo "Running initial setup"
	echo "Expect one restart"
	sudo echo "$LIVE" > "/etc/hostname"
	sudo printf "127.0.0.1\t\t$LIVE" >> "/etc/hosts"
	sudo sh -c "wpa_passphrase Bogli Disney19 >> /etc/wpa_supplicant/wpa_supplicant.conf"
	sudo sh -c "wpa_passphrase SamBox passtheboof >> /etc/wpa_supplicant/wpa_supplicant.conf"
	sudo reboot -h now
	#sudo apt-get --yes --force-yes update
	#sudo apt-get --yes --force-yes install git
	#sudo apt-get --yes --force-yes install nodejs
	#sudo apt-get --yes --force-yes install lynx
else
	echo "This server was initialized"
	repoArray=("QuickOnes" "AmberGo")
	echo "${repoArray[@]}"
	for i in "${repoArray[@]}"
	do
		echo -n $i: >> silly.txt
		git -C $i/ pull >> silly.txt || echo "" >> silly.txt
		tail -1 silly.txt
	done
fi
