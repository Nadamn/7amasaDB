#!/usr/bin/bash

#this file is called with argument $1 DBName

tmpForm=$(yad \
--center \
--title "7amasa DB Engine" \
--form --field="Enter table Name" \
--form --entry-label="Enter table Name" \
--button=gtk-ok:0 \
--button=gtk-cancel:1 \
)

choice0=$?

if [ $choice0 = 1 ]
then
	continue

elif [ $choice0 = 252 ]
then 
	kill -9 `ps --pid $$ -oppid=`; exit
elif [ $choice0 = 0 ]
then
	tName=$(echo $tmpForm | awk 'BEGIN {FS="|" } { print $1 }')

	while [ true ]
	do
		typeset -i flag=1
		if [[ `grep -c "$tName" /var/7amasaDB/$1/.meta` -gt 0 ]]
		then
			if [ ! $tName ]
			then 
				flag=0
			else
				tForm=$(yad \
					--center \
					--title "7amasa DB Engine" \
					--text "$tName Table" \
					--text-align=center \
					--button="1) Display content":1 \
					--button="2) insert new record":2 \
					--button="3) update record":3 \
					--button="4) delete record":4 \
					--button="5) back":5 \
					)

				choice=$?
				
				case $choice in 
				1) 
					
					d=$(cat /var/7amasaDB/$1/$tName)
					echo $d
					{ printf '%s\t' "${d[@]}"| yad --text-info --width="200" --height="200" --title="Table content" \
					--button="back:1" \
					2>/dev/null
					};

				;;
				2) ./insert_record.sh $1 $tName
				;;
				3) ./modify.sh $1 $tName
				;;
				4) ./delete_record.sh $1 $tName
				;;
				5) break
				;;
				252) kill -9 `ps --pid $$ -oppid=`; exit 
				;;
				esac
			fi
		else
			flag=0
		fi
		
		if [[ $flag -eq 0 ]]
		then
			tmpForm=$(yad \
			--center \
			--title "7amasa DB Engine" \
			--text "$tName Table not found" \
			--button=gtk-go-back:1	\
			)
			break
		fi

		
	done

fi
