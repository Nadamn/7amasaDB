#!/usr/bin/bash

tmpForm=$(yad \
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

	if [ -d /var/7amasaDB/$DBName -a $DBName ] 
	then
		tmpForm=$(yad \
		--center \
		--title "7amasa DB Engine" \
		--text "Are you sure that you want to delete database $DBName ?" \
		--button="yes":1 \
		--button="NO":2 \
		)
		choice=$?

		case $choice in
			1)	rm -r -f /var/7amasaDB/$DBName
			if [ ! -d /var/7amasaDB/$DBName ]
			then
				tmpForm=$(yad \
				--center \
				--title "7amasa DB Engine" \
				--text "$DBName Deleted Successfully" \
				--button=gtk-go-back:1 \
				)
				./index.sh
			fi
			;;
			2) ./index.sh
			;;
			252) kill -9 `ps --pid $$ -oppid=`; exit
			;;
		esac
	else
		tmpForm=$(yad \
		--center \
		--title "7amasa DB Engine" \
		--text "$DBName Database not found" \
		--button=gtk-go-back:1 \
		)
		continue
	fi
fi



	
