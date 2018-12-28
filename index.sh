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
	--title "7amasa DB" --text "Welcome to 7amasaDB:" \
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

		2) 
		tmpForm=$(yad --title "7amasa DB" --text "Enter Database Name: " --form --field="name" )
		DBName=$(echo $tmpForm | awk 'BEGIN {FS="|" } { print $1 }') 

		if [ -d /var/7amasaDB/$DBName ] #change name
		then
			./delete_database.sh $DBName
			continue
		else
			yad --title "7amasa DB" --text "Database not found" --button="OK":1
			continue
		fi
		break	
		;;

		3) ./switch_to_db.sh 
			continue
		;;

		4) exit
		;;

		*) echo Choose a Valid Option! please..
	esac
done
