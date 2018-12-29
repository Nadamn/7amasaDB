#!/usr/bin/bash

#next if checks if database engine not installed, then exit the script
if [ ! -d /var/7amasaDB ]
then
	echo "Engine is not installed, please install it firstly using install_engine.sh script"
	exit
fi

while true
do

	mainForm=$(yad \
	--center \
	--title "7amasa DB Engine" \
	--text "Welcome to 7amasaDB" \
	--text-align=center \
	--button="1) Create New Database":1 \
	--button="2) Delete Existing Database":2 \
	--button="3) Switch to Database":3 \
	--button="4) exit":4 \
	)


	choice=$?

	case $choice in
		1) ./create_db.sh
		break
		;;

		2) ./delete_database.sh
		break
		;;

		3) ./switch_to_db.sh 
			continue
		;;

		4)
		exit 
		;;
		252) exit
		;;
	esac
done
