#! /usr/bin/bash

# this script takes database name as input an argument 
# N : not null
# I : integer 
# S : string 
# example : Ni not null and integer

succ=0

while [ $succ = 0 ]
do

clear
read -p "Enter table name: " Table_name 

exist=0

for name in `ls /var/7amasaDB/$S1`
do
	 
	if [ $Table_name = $name ]
	then 
		exist=1
		break
	fi
done 



if [ $exist = 1 ]
then 
	echo "This table already exists"
	succ=0
else 
	touch /var/7amasaDB/$1/$Table_name
	
	if [ $? != 0 ] 
	then 
		succ=0
		echo "This name is not valid!"
	else
		succ=1
		echo "your table created successfully!"
	#	touch /var/7amasaDB/$dbname/.meta
	#	echo "dbname:"$dbname >> /var/7amasaDB/$dbname/.meta
	fi 
	
fi 

done

clear
read -p "Enter number of columns in your table: " noc

for (( i=1; i<=$noc; i++ ))
do 
	if [ $i -eq 1 ]
	then
		clear
		read -p "Enter column name [PK] $i/$noc: " arr_tab[$i]
		arr_meta[1]=$Table_name
		arr_meta[2]=$noc
		arr_meta[3]="4"
		arr_meta[4]="N"
	else
		clear
		read -p "Enter column name $i/$noc: " arr_tab[$i]
		select choice in 'Can be Null' 'Cannot be Null'
		do 
		case $REPLY in 
			1)	arr_meta[(($i+3))]=""
				break
				;;
			2)	
				arr_meta[(($i+3))]="N"
				break
				;;
		esac
		done
	fi
	
	clear
	echo "Select column datatype"
	select ch in 'Int' 'String'
	do 
	case $REPLY in
		1)
			arr_meta[(($i+3))]=${arr_meta[(($i+3))]}"I"
			break
			;;
		2)
			arr_meta[(($i+3))]=${arr_meta[(($i+3))]}"S"
			break
			;;
	esac
	done
		
done

#line_meta=${arr_meta[*]}
#line_tab=${arr_tab[*]}

line_meta=`echo "${arr_meta[*]}" | sed "s/ /:/g"`
line_tab=`echo "${arr_tab[*]}" | sed "s/ /:/g"`


echo $line_meta
echo $line_tab

echo $line_meta >> /var/7amasaDB/$1/.meta
echo $line_tab >> /var/7amasaDB/$1/$Table_name




