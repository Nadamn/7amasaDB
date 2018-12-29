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
	exit 1
elif [ $choice0 = 0 ]
then
	DBName=$(echo $tmpForm | awk 'BEGIN {FS="|" } { print $1 }') 
    echo $DBName
    if [ -d /var/7amasaDB/$DBName -a $DBName ]
    then
        while true
        do
            DBForm=$(yad \
            --center \
            --title "7amasa DB Engine" \
            --text-align=center \
            --text "$DBName" \
            --button="1) Add Table":1 \
            --button="2) Delete Table":2 \
            --button="3) switch to table":3 \
            --button="4) back":4 \
            )


            choice=$?

            case $choice in
                1) ./create_table.sh $DBName
                ;;
                2) ./delete_table.sh $DBName
                continue
                ;;
                3) ./table_index.sh $DBName
                continue
                ;;
                4) break
                ;;
                252) exit 1
                ;;
            esac
        done
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
