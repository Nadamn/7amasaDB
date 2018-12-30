#!/usr/bin/bash

#this script takes database name as argument 1 $1
    
if [ -d /var/7amasaDB/$1 -a $1 ]
then
    while true
    do
        DBForm=$(yad \
        --center \
        --title "7amasa DB Engine" \
        --text-align=center \
        --text "$1" \
        --button="1) Add Table":1 \
        --button="2) Delete existing Table":2 \
        --button="3) switch to table":3 \
        --button="4) back":4 \
        )


        choice=$?

        case $choice in
            1) ./create_table.sh $1
            ;;
            2) ./delete_table.sh $1
            continue
            ;;
            3) ./table_index.sh $1
            continue
            ;;
            4) break
            ;;
            252) kill -9 `ps --pid $$ -oppid=`; exit
            ;;
        esac
    done
else
    tmpForm=$(yad \
    --center \
    --title "7amasa DB Engine" \
    --text "$1 Database not found" \
    --button=gtk-go-back:1 \
    )
    continue
fi    
