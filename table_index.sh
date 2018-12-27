#!/usr/bin/bash

#this file is called with argument $1

echo "Insert Table Name: "
read tName

select choice in "insert new record" "update record" "exit"
do
	case $REPLY in 
	1) ./insert_record.sh $1 $tName
	;;
	2) echo "update record"
	;;
	3) exit ;;
	esac
done
