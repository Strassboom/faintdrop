#!/bin/bash
LIVE=kiibo
host=$(hostname)
repoListFile="repos.txt"
repoLogFile="repologs.txt"
if [ $host != $LIVE ]
then
        echo $'This server is not initialized\nRunning initial setup\nExpect one restart'
	sudo echo "$LIVE" > "/etc/hostname"
	sudo printf "127.0.0.1\t\t$LIVE" >> "/etc/hosts"
	sudo sh -c "wpa_passphrase Bogli Disney19 >> /etc/wpa_supplicant/wpa_supplicant.conf"
	sudo sh -c "wpa_passphrase SamBox passtheboof >> /etc/wpa_supplicant/wpa_supplicant.conf"
	touch "$repoListFile"
	touch "$repoLogFile"
	sudo reboot -h now
	sudo apt-get --yes update
	yes | sudo apt-get install git
	sudo apt-get --yes install nodejs
	sudo apt-get --yes install lynx
else
	echo "This server was initialized"
	declare -a okay;
	readarray -t okay < "$repoListFile"
	echo "${okay[@]}"
	for i in "${okay[@]}"
	do
		echo -n $i: >> "$repoLogFile"
		if [ ! -d "${i##*/}" ]
		then
			sudo git clone "https://github.com/$i.git/" >> "$repoLogFile"
			if [ -d "${i##*/}/.git" ]
			then
				sudo echo "Clone into ${i##*/} complete" >> "$repoLogFile"
			else
				sudo echo "Clone into ${i##*/} failed" >> "$repoLogFile"
			fi
		else
			git -C "${i##*/}/" pull >> "$repoLogFile"
		fi
		tail -1 "$repoLogFile"
	done
fi
