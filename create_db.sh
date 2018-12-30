#! /usr/bin/bash 
regex='^[a-z|A-Z][0-9|a-z|A-Z|_|\d]*$'
succ=0

while [ $succ = 0 ]
do



while true
	do
		dbname=$(yad \
		--center \
		--text-align=center \
		--title "7amasa DB" \
		--form --field="Enter your database name: " \
		--button=gtk-ok:0 \
		--button=gtk-cancel:1 \
		)

		choice0=$?

		dbname=$(echo $dbname | awk 'BEGIN {FS="|" } { print $1 }')

		if [ $choice0 = 1 ]
		then
			break 2

		elif [ $choice0 = 252 ]
		then 
			kill -9 `ps --pid $$ -oppid=`; exit
		elif [ $choice0 = 0 ]
		then
			if [[ $dbname && $dbname =~ $regex ]]
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
	yad \
	--title "7amasa DB Engine" \
	--center \
	--text-align=center \
	--text "This name already exists" \
	--button="back":1
	succ=0
else 
	mkdir /var/7amasaDB/$dbname
	
	if [ $? != 0 ] 
	then 
		succ=0
		yad \
		--title "7amasa DB Engine" \
		--center \
		--text-align=center \
		--text "This name is not valid!" \
		--button="back":1	

	else
		succ=1

		yad \
		--title "7amasa DB Engine" \
		--center \
		--text-align=center \
		--text "your database created successfully!"\
		--button="back":1	
		touch /var/7amasaDB/$dbname/.meta
		echo "dbname:"$dbname >> /var/7amasaDB/$dbname/.meta

		./switch_to_db.sh $dbname
	fi 
	
fi 

done 
