#!/usr/bin/bash

#next if checks if database engine not installed, then exit the script
if [ ! -d /var/7amasaDB ]
then
	echo "Engine is not installed, please install it firstly using install_engine.sh script"
	exit
fi

echo "Welcome to 7amasaDB" ## change name


PS3="main menu select: "
select choice in "List Databases" "Create New Database" "Delete Existing Database" "Switch to Database" "exit"
do
	PS3="main menu select: "
	case $REPLY in
	        1)
                ls -1 "/var/7amasaDB/"
                ;;

		2) ./create_db.sh
		break
		;;

		3) echo "Enter Database Name"
		read DBName
		if [ -d /var/7amasaDB/$DBName ] #change name
		then
			./delete_database.sh $DBName
		else
			echo "Database Not found"
		fi
		break	
		;;
		4)
                echo "Enter Database Name: "
                read DBName
		if [ -d "/var/7amasaDB/$DBName" ]
		then
			PS3="database $DBName select: "
			select choice2 in "List tables" "Add Table" "Delete Table" "Delete Database" "switch to table" "back" "exit" #choices of a specific database
			do
				case $REPLY in
					1)ls -1 /var/7amasaDB/$DBName 
					;;
					2) ./create_table.sh $DBName
					;;
					3) ./delete_table.sh $DBName
					;;
					4) 	./delete_database.sh $DBName
					;;
					5) 	./table_index.sh $DBName
					;;
					6) echo "1) Create New Database	      2) Delete Existing Database
	3) Switch to Database	      4) exit"
					break
					;;
					7) exit
					;;
					*) echo Choose a Valid Option! please..
				esac
			done
		else
			echo "Database Not found"
		fi    
		;;

		4) exit
		;;

		*) echo Choose a Valid Option! please..
	esac
done
