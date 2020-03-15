#!/bin/bash
LIVE=miguel
host=$(hostname)
pkgCheckFile="packageCheck.txt"
repoListFile="repos.txt"
repoLogFile="repologs.txt"
if [ $host != $LIVE ]
then
        echo $'This server is not initialized\nRunning initial setup\nExpect one restart'
	sudo echo "$LIVE" > "/etc/hostname"
	sudo echo -e "127.0.0.1\t\t$LIVE" >> "/etc/hosts"
	sudo sh -c "wpa_passphrase Bogli Disney19 >> /etc/wpa_supplicant/wpa_supplicant.conf"
	sudo sh -c "wpa_passphrase SamBox passtheboof >> /etc/wpa_supplicant/wpa_supplicant.conf"
	touch "$pkgCheckFile"
	echo -n "" > "$repoListFile"
	echo -n "" >  "$repoLogFile"
	sudo apt-get --yes update
	sudo apt-get install git -y
	sudo apt-get install nodejs -y
	sudo apt-get install lynx -y
	sudo reboot -h now
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
