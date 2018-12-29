#!/usr/bin/bash

#this script needs to be called with arguments 2 the DB name and table name


	

	while true
	do

			read -p "Enter record Primary key: " key
			#echo $key 
	
			line=`grep -w "$key" /var/7amasaDB/$1/$2`
			linenumber=`grep -wrne  "$key" /var/7amasaDB/$1/$2 | cut -d: -f 1`

			if [ -z "$line" ] 
			then 
				echo "This id not exist!"
			else
				break
			fi
	done



	ln="$linenumber"d

	sed -i "$ln" /var/7amasaDB/$1/$2

	#sed -n "$ln" /var/7amasaDB/$1/$2
	#sed -i "/$pkValue/d" /var/7amasaDB/$1/$2


