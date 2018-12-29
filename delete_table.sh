#!/usr/bin/bash

#this script needs to be called with argument 1 the DB name

tmpForm=$(yad --title "7amasa DB" --text "Enter Table Name: " --form --field="name" )
tName=$(echo $tmpForm | awk 'BEGIN {FS="|" } { print $1 }') 

if [ ! -f /var/7amasaDB/$1/$tName ] #change name
then
		yad --title "7amasa DB" --text "Table doesn't exist" --button="back":1
		#echo /var/7amasaDB/$1/$tName 
		exit
fi

tmpForm=$(yad --title "7amasa DB" --text "Are you sure you want to delete table $tName? " --button="Yes":1 --button="No":2)
choice=$?

case $choice in
	1) rm -f /var/7amasaDB/$1/$tName
	#echo `grep "$tName" /var/7amasaDB/$1/.meta`
	sed -i "/$tName/d" /var/7amasaDB/$1/.meta
	break
	;;
	
	2)
	break
	;;
esac

#t1:3:4:NI:NS:I
