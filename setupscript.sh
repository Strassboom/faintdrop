#!/bin/bash
LIVE=overwatch
host=$(hostname)
if [ $host != $LIVE ]
then
        echo $'This server is not initialized\nRunning initial setup\nExpect one restart'
	sudo echo "$LIVE" > "/etc/hostname"
	sudo printf "127.0.0.1\t\t$LIVE" >> "/etc/hosts"
	sudo sh -c "wpa_passphrase Bogli Disney19 >> /etc/wpa_supplicant/wpa_supplicant.conf"
	sudo sh -c "wpa_passphrase SamBox passtheboof >> /etc/wpa_supplicant/wpa_supplicant.conf"
	sudo reboot -h now
	sudo apt-get --yes update
	yes | sudo apt-get install git
	sudo apt-get --yes install nodejs
	sudo apt-get --yes install lynx
else
	echo "This server was initialized"
	repoArray=("QuickOnes" "AmberGo")
	declare -a okay;
	readarray -t okay < "repos.txt"
	echo "${okay[@]}"
	#echo "${repoArray[@]}"
	for i in "${repoArray[@]}"
	do
		echo -n $i: >> silly.txt
		git -C $i/ pull >> silly.txt || echo "" >> silly.txt
		tail -1 silly.txt
	done
fi
