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
		continue
		;;

		2) ./delete_database.sh
		continue
		;;

		3) 	tmpForm=$(yad \
			--center \
			--title "7amasa DB Engine" \
			--form --field="Enter Database Name" \
			--button=gtk-ok:0 \
			--button=gtk-cancel:1 \
			)

			choice0=$?

			if [ $choice0 = 1 ]
			then
				continue

			elif [ $choice0 = 252 ]
			then 
				kill -9 `ps --pid $$ -oppid=`; exit
			elif [ $choice0 = 0 ]
			then
				DBName=$(echo $tmpForm | awk 'BEGIN {FS="|" } { print $1 }') 
				./switch_to_db.sh $DBName
			fi
			continue
		;;

		4)
		exit 
		;;
		252) exit
		;;
	esac
done
