#!/usr/bin/bash 

#this file is called with argument $1 db name and table name $2

export IFS=":"
typeset -i colNum=3
typeset -i i=-1
intPattern='[0-9]+$'

typeset -i noColumns
noColumns=`grep -w "$2" /var/7amasaDB/$1/.meta | cut -d: -f 2`

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

notDone=1

while (($notDone))  
do 
	#echo $line 
	read -p "Enter column number to edit or 'Q' to exit:" choice
	
	if (( $choice > $noColumns ))
	then 
		echo "Column number is out of range"
		continue	
	fi 

	if [ "$choice" = "Q" -o "$choice" = "q" ]
	then
		notDone=0
	else
		while true
		do
			ln="$linenumber"p
		    	#echo $ln		
			#old=`grep $key /var/7amasaDB/$1/$2 | cut -d: -f $choice`
			old=`sed -n "$ln" /var/7amasaDB/$1/$2 | cut -d: -f $choice`
			#echo $old
			
			colNum=$choice+3		
			constraint=`grep -w "$2" /var/7amasaDB/$1/.meta | cut -d: -f $colNum`

			echo "previous:$old"
			read -p "New:" colVal
	
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
					uniq=`grep -w  "$colVal" /var/7amasaDB/$1/$2 | cut -d: -f 1`
					if [ $uniq ]
					then
						echo "id with the same value exists"
						flag=0
						continue
					fi 
				fi
			fi

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


			if [ $flag -eq 1 ]
			then
				lnumber="$linenumber"s
				sed -i "$lnumber/$old/$colVal/" /var/7amasaDB/$1/$2
				line=$( sed "s/$old/$colVal/g" <<< $line)
				break
			fi

		done

	fi
done


