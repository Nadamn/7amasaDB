#!/usr/bin/bash 

#this file is called with argument $1 db name and table name $2

export IFS=":"
typeset -i colNum=3
typeset -i i=-1
intPattern='[0-9]+$'
regex='^[a-z|A-Z|0-9][0-9|a-z|A-Z|_|\d]*$'


for col in `head -n 1 /var/7amasaDB/$1/$2`
do
	flag=1
	colNum=$colNum+1
	constraint=`grep -w "$2" /var/7amasaDB/$1/.meta | cut -d: -f $colNum`

	while true
	do

		tmpForm=$(yad --title "7amasa DB" --form --field="$col" --button="OK":1)
		colVal=$(echo $tmpForm | awk 'BEGIN {FS="|" } { print $1 }') 
		echo $colVal

		if [[ $colVal =~ $regex ]]
		then
			echo hello

			if [ ! $colVal ]
			then
				if [ "$constraint" = "NS" -o "$constraint" = "NI" ]
				then
					flag=0
					yad \
					--title "7amasa DB" --text "$col can't be null" \
					--button="back":1
					continue
				else
					colVal="  "
					flag=1
				fi


				

			else
					if [[ $colNum -eq 4  ]]
					then
						uniq=`grep -w "$colVal" /var/7amasaDB/$1/$2 | cut -d: -f 1`
						if [ $uniq ]
						then
							echo "id with the same value exists"
							flag=0
							continue
						fi
					fi

					if [ "$constraint" = "NI" -o "$constraint" = "I" ]
					then
						if [[ $colVal =~ $intPattern ]]
						then
							flag=1
						else
							flag=0
							yad \
							--title "7amasa DB" --text "$col must be an integer" \
							--button="back":1
							continue
						fi
					else

						flag=1

					fi
			fi


			if [ $flag -eq 1 ]
			then
					i=$i+1
					columns[$i]=$colVal
					break
			fi


		else
			yad \
			--title "7amasa DB" \
			--text "value contains unaccepted characters or white spaces" \
			--button="back":1
			continue
		fi


	done

done

i=0
while [[ $i -lt ${#columns[*]}-1 ]]
do
	newline=$newline${columns[$i]}":"
	i=i+1
	if [[ $i -eq ${#columns[*]}-1 ]]
	then
		newline="$newline${columns[$i]}"
	fi
done

echo "$newline" >> /var/7amasaDB/$1/$2