#! /usr/bin/bash 
regex='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'
succ=0

while [ $succ = 0 ]
do


 


while true
	do 
		read -p "Enter your database name: " dbname
		
		if [[ $dbname =~ $regex ]]
		then
			break
		else
			echo "Invalid characters"
		fi
	done
 


exist=0

for name in `ls /var/7amasaDB`
do
	 
	if [ $dbname = $name ]
	then 
		exist=1
		break
	fi
done 


if [ $exist = 1 ]
then 
	echo "This name already exists"
	succ=0
else 
	mkdir /var/7amasaDB/$dbname
	
	if [ $? != 0 ] 
	then 
		succ=0
		echo "This name is not valid!"
	else
		succ=1
		echo "your database created successfully!"
		touch /var/7amasaDB/$dbname/.meta
		echo "dbname:"$dbname >> /var/7amasaDB/$dbname/.meta
	fi 
	
fi 

done 
