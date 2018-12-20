#!/usr/bin/bash

#next if checks if database engine not installed, then exit the script
if [ ! -d /var/7amasaDB ]
then
	echo "Engine is not installed, please install it firstly using install_engine.sh script"
	exit
fi


echo "Welcome to 7amasaDB" ## change name

PS3="select: "
select choice in "Create New Database" "Delete Existing Database" "Switch to Database"
do
case $REPLY in
	1) echo Create New DataBase ## add its script
	break
	;;
	2) echo Delete Existing Database ## add its script
	break	
	;;
	3) echo Switch to DataBase ## add its script
	break
	;;
	*) echo Choose a Valid Option! please..
esac
done
