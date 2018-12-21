#!/usr/bin/bash

#this file is called with argument $1 db name and $2 table name

export IFS=":"
typeset -i colNum=3

for col in `head -n 1 /var/7amasaDB/$1/$2`
do
	flag=0
	while true
	do
		echo "$col: "
		read colVal
		colNum=colNum+1
		constraint=`grep "$2" /var/7amasaDB/$1/.meta | cut -d: -f $colNum`	
		echo "$constraint"
		if [ ! $colVal ]
		then
			if [ $colVal=NS -o $constraint=NI ]
			then
				echo "not null"
			else
				flag=1
			fi
		else
			if [ $constraint=NI -a $colVal=~'^[0-9]+$' ]
			then
				flag=1
			else
				echo "$colVal should be int"
			fi
		fi
		if [ $flag -eq 1 ]
		then
			break
		fi
	done
done


