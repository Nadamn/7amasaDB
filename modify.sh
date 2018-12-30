#!/usr/bin/bash -x

#this file is called with argument $1 db name and table name $2

export IFS=":"
typeset -i colNum=3
typeset -i i=-1
intPattern='[0-9]+$'
regex='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'

typeset -i noColumns
noColumns=`grep -w "$2" /var/7amasaDB/$1/.meta | cut -d: -f 2`

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
			colVal=$(echo $key | awk 'BEGIN {FS="|" } { print $1 }') 
	
			line=`grep -w "$colVal" /var/7amasaDB/$1/$2`
			linenumber=`grep -wrne  "$colVal" /var/7amasaDB/$1/$2 | cut -d: -f 1`

			if [ -z "$line" ] 
			then 
				yad \
				--title "7amasa DB Engine" \
				--center \
				--text-align=center \
				--text "This id not exist!" \
				--button="back":1 
			else
				break
			fi
		fi
done

notDone=1

while (($notDone))  
do 
	#echo $line 
	
	key=$(yad \
		--center \
		--text-align=center \
		--title "7amasa DB" \
		--form --field="Enter column number to edit or cancel:" \
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
			colVal=$(echo $key | awk 'BEGIN {FS="|" } { print $1 }') 

	
			if (( $colVal > $noColumns ))
			then 
				yad \
				--title "7amasa DB Engine" \
				--center \
				--text-align=center \
				--text "Column number is out of range" \
				--button="back":1 
				continue	
			fi
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

			key=$(yad \
			--center \
			--text-align=center \
			--title "7amasa DB" \
			--form --field="previous:$old new:" \
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
				colVal=$(echo $key | awk 'BEGIN {FS="|" } { print $1 }') 
		
				if [[ $colVal =~ $regex ]]
		        	then

					if [ ! $colVal ]
					then
						if [ "$constraint" = "NS" -o "$constraint" = "NI" ]
						then
							flag=0
							yad \
							--title "7amasa DB Engine" \
							--center \
							--text-align=center \
							--text "$col can't be null" \
							--button="back":1
							continue
						else
							flag=1
						fi
		
					else
						if [[ $colNum -eq 4  ]]
						then
							uniq=`grep -w  "$colVal" /var/7amasaDB/$1/$2 | cut -d: -f 1`
							if [ $uniq ]
							then
								flag=0
								yad \
								--title "7amasa DB Engine" \
								--center \
								--text-align=center \
								--text "id with the same value exists" \
								--button="back":1
								continue
							fi
						fi 
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
						--title "7amasa DB Engine" \
						--center \
						--text-align=center \
						--text "$col must be an integer" \
						--button="back":1
						continue
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
			else
				yad \
				--title "7amasa DB Engine" \
				--center \
				--text-align=center \
				--text "value contains unaccepted characters or white spaces" \
				--button="back":1
				
			fi
			
																
			
		done
		

	fi
done


