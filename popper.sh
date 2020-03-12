if [[ ( $1 == "help" ) || ( $# < 2 )]]
then
	echo "-help	Lists arguments"
	echo "popper.sh [user] [IP-address or hostname]"
else
	#echo $#
	scp birds.sh $1@$2:
	#cat commands.sh "${@}" | ssh $1@$2
	ssh $1@$2 "echo ${@:3} > repos.txt; tr '\t' '\n' < repos.txt > repos.txt; sudo grep -qxF './birds.sh' .bashrc || sudo echo './birds.sh' >> .bashrc;sudo chmod +x birds.sh"
fi
