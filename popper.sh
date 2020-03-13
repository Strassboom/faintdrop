if [[ ( $1 == "help" ) || ( $# < 2 )]]
then
	echo "-help	Lists arguments"
	echo "popper.sh [user] [IP-address or hostname]"
else
	#echo $#
	scp setupscript.sh $1@$2:
	printf $'%s\n' "${@:3}";
	ssh $1@$2 "printf $'%s\n' ${@:3} > repos.txt; sudo grep -qxF 'sudo ./setupscript.sh' .bashrc || sudo echo 'sudo ./setupscript.sh' >> .bashrc;sudo chmod +x setupscript.sh"
fi
