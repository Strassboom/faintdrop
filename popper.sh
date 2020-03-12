if [[ ( $1 == "help" ) || ( $# < 2 )]]
then
	echo "-help	Lists arguments"
	echo "popper.sh [user] [IP-address or hostname]"
else
	echo $#
	scp birds.sh $1@$2:
	cat commands.sh | ssh $1@$2
fi
