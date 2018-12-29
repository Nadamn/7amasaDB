#!/usr/bin/bash

#this file is called with argument $1 DBName

tmpForm=$(yad --title "7amasa DB" --text "Enter table Name: " --form --field="name" )
tName=$(echo $tmpForm | awk 'BEGIN {FS="|" } { print $1 }') 

while true
do
	if [[ ! `grep -c "$tName" /var/7amasaDB/$1/.meta` -gt 0 ]]
	then
			yad \
			--title "7amasa DB" --text "Table Not Found" \
			--button="back":1
			break
	fi

	tForm=$(yad \
        --title "7amasa DB" --text "Welcome to 7amasaDB:" \
        --button="1) Display content":1 \
        --button="2) insert new record":2 \
        --button="3) update record":3 \
        --button="4) exit":4 \
        )

	choice=$?
	
	case $choice in 
	1) cat /var/7amasaDB/$1/$tName
	;;
	2) ./insert_record.sh $1 $tName
	;;
	3) ./modify.sh $1 $tName
	;;
	4) break 
	;;
	esac
done
