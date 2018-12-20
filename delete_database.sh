#!/usr/bin/bash

PS3="> "
echo "Are you sure that you want to delete database $choice2 ?"
select choice3 in "y" "n"
do
	case $REPLY in
		1)	cd /var/7amasaDB  #change name
		rm -r -f $1
		break
		;;
		2) break
		;;
		*) echo Choose a Valid Option! please..
	esac
done

