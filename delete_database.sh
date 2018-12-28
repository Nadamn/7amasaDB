#!/usr/bin/bash

tmpForm=$(yad --title "7amasa DB" --text "Are you sure that you want to delete database $1 ?" --form \
--button="yes":1 --button="NO":2
)

choice=$?

echo $choice

case $choice in
	1)	cd /var/7amasaDB  #change name
	rm -r -f $1
	;;
	2) 
	;;
esac
	
