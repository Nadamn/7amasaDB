#! /usr/bin/bash 

succ=0

while [ $succ = 0 ]
do


read -p "Enter your database name: " dbname 

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
