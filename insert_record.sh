#!/usr/bin/bash 

#this file is called with argument $1 db name

export IFS=":"
typeset -i colNum=3
typeset -i i=-1
intPattern='[0-9]+$'

echo "Enter table Name"
read tName

if [[ ! `grep -c "$tName" /var/7amasaDB/$1/.meta` -gt 0 ]]
then
	echo table not found
	exit
fi


for col in `head -n 1 /var/7amasaDB/$1/$tName`
do
	flag=1
	colNum=$colNum+1
	constraint=`grep "$tName" /var/7amasaDB/$1/.meta | cut -d: -f $colNum`

	while true
	do
		echo "$col: "
		read colVal
	
		if [ ! $colVal ]
		then
			if [ "$constraint" = "NS" -o "$constraint" = "NI" ]
			then
				echo "$col can't be null"
				flag=0
			else
				flag=1
			fi

		else
			if [[ $colNum -eq 4  ]]
			then
				uniq=`grep "$colVal" /var/7amasaDB/$1/$tName | cut -d: -f $colNum`
				if [ $uniq ]
				then
					echo "id with the same value exists"
					flag=0
				else
					if [ "$constraint" = "NI" -o "$constraint" = "I" ]
					then
						if [[ $colVal =~ $intPattern ]]
						then
							flag=1
						else
							echo "$col must be an integer"
							flag=0
						fi
					else
						flag=1
					fi
		
				fi
			fi
		fi


		if [ $flag -eq 1 ]
		then
			i=$i+1
			columns[$i]=$colVal
			break
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

echo "$newline" >> /var/7amasaDB/$1/$tName

