#!/usr/bin/bash

tmpForm=$(yad --title "7amasa DB" --text "Enter Database Name: " --form --field="name" )
DBName=$(echo $tmpForm | awk 'BEGIN {FS="|" } { print $1 }') 

if [ -d /var/7amasaDB/$DBName ]
then
    DBForm=$(yad \
	--title "7amasa DB" --text "Welcome to 7amasaDB:" \
	--button="1) Add Table":1 \
	--button="2) Delete Table":2 \
	--button="3) Insert Record":3 \
	--button="3) Update Record":4 \
	--button="3) Delete Record":5 \
	--button="3) Delete Database":6 \
	--button="3) back":7 \
	--button="4) exit":8 \
	)


	choice=$?

    case $choice in
        1) ./create_table.sh $DBName
        ;;
        2) ./delete_table.sh 
        ;;
        3) ./insert_record.sh $DBName 
        ;;
        4) echo "update record" ## add its script
        ;;
        5) echo "delete table" ## add its script
        ;;
        6) 	./delete_database.sh $DBName
        ;;
        7)
        break
        ;;
        8) break
        ;;
        *) echo Choose a Valid Option! please..
    esac
else
    echo "Database Not found"
fi    