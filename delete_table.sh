#!/usr/bin/bash

#this script needs to be called with argument 1 the DB name

tmpForm=$(yad \
--center \
--title "7amasa DB Engine" \
--form --field="Enter Table Name" \
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
	tName=$(echo $tmpForm | awk 'BEGIN {FS="|" } { print $1 }') 

	if [ -f /var/7amasaDB/$1/$tName -a $tName ] 
	then
		tmpForm=$(yad \
		--center \
		--title "7amasa DB Engine" \
		--text "Are you sure that you want to delete table $tName ?" \
		--button="yes":1 \
		--button="NO":2 \
		)
		choice=$?

		case $choice in
			1) rm -f /var/7amasaDB/$1/$tName
			sed -i "/$tName/d" /var/7amasaDB/$1/.meta
			continue
			;;
			
			2)
			continue
			;;
			
			252)
			kill -9 `ps --pid $$ -oppid=`; exit
			;;
		esac
	else
		tmpForm=$(yad \
		--center \
		--title "7amasa DB Engine" \
		--text "$tName Table not found" \
		--button=gtk-go-back:1	\
		)
		continue
	fi

fi
