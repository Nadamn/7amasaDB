#!/usr/bin/bash

#this file is called with argument $1

echo "Insert Table Name: "
read tName

if [[ ! `grep -c "$2" /var/7amasaDB/$1/.meta` -gt 0 ]]
then
        echo table not found
        exit
fi


select choice in "Display content" "insert new record" "update record" "exit"
do
	case $REPLY in 
	1) cat /var/7amasaDB/$1/$tName
	;;
	2) ./insert_record.sh $1 $tName
	;;
	3) ./modify.sh $1 $tName
	;;
	4) exit ;;
	esac
done
