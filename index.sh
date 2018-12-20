#!/usr/bin/bash

#next if checks if database engine not installed, then exit the script
if [ ! -d /var/7amasaDB ]
then
	echo "Engine is not installed, please install it firstly using install_engine.sh script"
	exit
fi


echo "Welcome to 7amasaDB" ## change name

PS3="select: "
select choice in "Create New Database" "Delete Existing Database" "Switch to Database" "exit"
do
case $REPLY in
	1) echo Create New DataBase ## add its script
	break
	;;
	2) echo Delete Existing Database ## add its script
	break	
	;;
	3)
	echo "Enter Database Name: "
	read DBName
	if [ -d /var/7amasaDB/$DBName ]
	then
		cd /var/7amasaDB/$DBName
		select choice2 in "Add Table" "Delete Table" "Insert Record" "Update Record" "Delete Record" "back" "exit" #choices of a specific database
		do
			case $REPLY in
				1) echo "add table" ## add its script
ls
				;;
				2) echo "delete table" ## add its script
				;;
				3) echo "insert record" ## add its script
				;;
				4) echo "update record" ## add its script
				;;
				5) echo "delete table" ## add its script
				;;
				6) echo "1) Create New Database	      2) Delete Existing Database
3) Switch to Database	      4) exit"
				break
				;;
				7) exit
				;;
				*) echo Choose a Valid Option! please..
			esac
		done
	else
		echo "Database Not found"
	fi    
	;;
	4) exit
	;;
	*) echo Choose a Valid Option! please..
esac
done
