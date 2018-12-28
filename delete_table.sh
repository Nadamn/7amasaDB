#!/usr/bin/bash

#this script needs to be called with argument 1 the DB name

echo "Enter table name"

read tName


if [ ! -f /var/7amasaDB/$1/$tName ] #change name
then
		echo "table doesn't exist"
		echo /var/7amasaDB/$1/$tName 
		exit
fi


PS3="> "

echo "Are you sure you want to delete table $tName? y/n"

select choice in "y" "n"
do
	case $REPLY in
		1) rm -f /var/7amasaDB/$1/$tName
		echo `grep "$tName" /var/7amasaDB/$1/.meta`
		sed -i "/$tName/d" /var/7amasaDB/$1/.meta
		break
		;;
		
		2)
		break;
		;;
		*) echo Enter a valid option! please..
	esac
done

#t1:3:4:NI:NS:I
