#! /usr/bin/bash 

# this script takes database name as input an argument 
# N : not null
# I : integer 
# S : string 
# example : Ni not null and integer
regex='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'
succ=0
dbname=$1

while [ $succ = 0 ]
do

clear

	while true
	do 
		
		Table_name=$(yad \
		--center \
		--text-align=center \
		--title "7amasa DB" \
		--form --field="Enter table name: "  \
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

			if [[ $Table_name && $Table_name =~ $regex ]]
			then
				Table_name=$(echo $Table_name | awk 'BEGIN {FS="|" } { print $1 }') 
				break
				
			else

					yad \
					--title "7amasa DB Engine" \
					--center \
					--text-align=center \
					--text "Invalid characters" \
					--button="back":1
			fi
		fi
	done
 
echo $Table_name
exist=0
echo $Table_name
for name in `ls /var/7amasaDB/$dbname`
do
	 
	if [ $Table_name = $name ]
	then 
		exist=1
		break
	fi
done 

echo $dbname


if [ $exist = 1 ]
then 

		yad \
		--title "7amasa DB Engine" \
		--center \
		--text-align=center \
		--text "This table already exists"\
		--button="back":1
		succ=0
else 
	touch /var/7amasaDB/$dbname/$Table_name
	
	if [ $? != 0 ] 
	then 
		succ=0
		yad \
		--title "7amasa DB Engine" \
		--center \
		--text-align=center \
		--text "This name is not valid!"\
		--button="back":1

	else
		succ=1

		yad \
		--title "7amasa DB Engine" \
		--center \
		--text-align=center \
		--text "your table created successfully!"\
		--button="back":1

	fi 
	
fi 

done


		noc=$(yad \
		--center \
		--text-align=center \
		--title "7amasa DB" \
		--form --field="Enter number of columns in your table: " \
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
			noc=$(echo $noc | awk 'BEGIN {FS="|" } { print $1 }') 
		fi










for (( i=1; i<=$noc; i++ ))
do 
	if [ $i -eq 1 ]
	then

        	while true
     	  	do

			newValue=$(yad \
			--center \
			--text-align=center \
			--title "7amasa DB" \
			--form --field="Enter column name [PK] $i/$noc: " \
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

						newValue=$(echo $newValue | awk 'BEGIN {FS="|" } { print $1 }')
						arr_tab[$i]=$newValue
						if [[ ${arr_tab[$i]} =~ $regex ]]
						then
					
											break
					
						else

											yad \
											--title "7amasa DB Engine" \
											--center \
											--text-align=center \
											--text "Invalid characters" \
											--button="back":1
						fi
			fi

               		
	        done
		prev[$i]=${arr_tab[$i]}
		arr_meta[1]=$Table_name
		arr_meta[2]=$noc
		arr_meta[3]="4"
		arr_meta[4]="N"
	else
		
	
       		 while true
       		 do
	                
			newValue=$(yad \
			--center \
			--text-align=center \
			--title "7amasa DB" \
			--form --field="Enter column name $i/$noc: "\
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

							newValue=$(echo $newValue | awk 'BEGIN {FS="|" } { print $1 }') 
		    	        
							if [[ $newValue =~ $regex ]]
					    	        then

											for var in "${arr_tab[@]}"
											do
												if [[ $var == $newValue ]]
												then 
														yad \
														--title "7amasa DB Engine" \
														--center \
														--text-align=center \
														--text "This name already exists" \
														--button="back":1
														continue 2	
												fi
											done
											
											arr_tab[$i]=$newValue
											break
		      	        			else
											yad \
											--title "7amasa DB Engine" \
											--center \
											--text-align=center \
											--text "Invalid characters" \
											--button="back":1
							fi
	
			 fi



	         done

		
		 mainForm=$(yad \
	       	 --center \
		 --title "7amasa DB Engine" \
		 --text "this column:" \
		 --text-align=center \
		 --button="1) Can be Null":1 \
		 --button="2) Cannot be Null":2 \
		 )

		 choice=$?
		
		 case $choice in 
			1)	arr_meta[(($i+3))]=""
				;;
			2)	
				arr_meta[(($i+3))]="N"
				;;
		 esac
		
	fi
	


	mainForm=$(yad \
	--center \
	--title "7amasa DB Engine" \
	--text "Select column datatype:" \
	--text-align=center \
	--button="1) Int":1 \
	--button="2) String":2 \
	)

	choice=$?
		
	case $choice in 
			1)
				arr_meta[(($i+3))]=${arr_meta[(($i+3))]}"I"
				;;
			2)
				arr_meta[(($i+3))]=${arr_meta[(($i+3))]}"S"
				;;
	esac
done





		


#line_meta=${arr_meta[*]}
#line_tab=${arr_tab[*]}

line_meta=`echo "${arr_meta[*]}" | sed "s/ /:/g"`
line_tab=`echo "${arr_tab[*]}" | sed "s/ /:/g"`


echo $line_meta
echo $line_tab

echo $line_meta >> /var/7amasaDB/$1/.meta
echo $line_tab >> /var/7amasaDB/$1/$Table_name




