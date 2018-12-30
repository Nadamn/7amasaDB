#!/usr/bin/bash

#this script needs to be called with arguments 2 the DB name and table name


	

	while true
	do



			key=$(yad \
					--center \
					--text-align=center \
					--title "7amasa DB" \
					--form --field="Enter record Primary key: " \
					--button=gtk-ok:0 \
					--button=gtk-cancel:1 \
					)

					choice0=$?

					if [ $choice0 = 1 ]
					then
						break 2

					elif [ $choice0 = 252 ]
					then 
						kill -9 `ps --pid $$ -oppid=`; exit
					elif [ $choice0 = 0 ]
					then
						key=$(echo $key | awk 'BEGIN {FS="|" } { print $1 }') 
						line=`grep -w "$key" /var/7amasaDB/$1/$2`
						linenumber=`grep -wrne  "$key" /var/7amasaDB/$1/$2 | cut -d: -f 1`

						if [ -z "$line" ] 
						then 
							yad \
							--title "7amasa DB Engine" \
							--center \
							--text-align=center \
							--text "This id not exist!"\
							--button="back":1
						else
							tmpForm=$(yad \
							--center \
							--title "7amasa DB Engine" \
							--text "Are you sure that you want to delete this record ?" \
							--button="yes":1 \
							--button="NO":2 \
							)
							choice=$?

							case $choice in
								1)	
									ln="$linenumber"d
									sed -i "$ln" /var/7amasaDB/$1/$2

									tmpForm=$(yad \
									--center \
									--title "7amasa DB Engine" \
									--text "$DBName Deleted Successfully" \
									--button=gtk-go-back:1 \
									)
									./table_index.sh
								;;
								2) ./table_index.sh
								;;
								252) kill -9 `ps --pid $$ -oppid=`; exit
								;;
							esac
			
						fi
					fi

	done




	#sed -n "$ln" /var/7amasaDB/$1/$2
	#sed -i "/$pkValue/d" /var/7amasaDB/$1/$2


