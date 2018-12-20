#!/usr/bin/bash

if [ ! -d /var/7amasaDB ]
then
	sudo mkdir /var/7amasaDB
	sudo chmod 777 /var/7amasaDB
	echo "7amasa DB created and ready to use" ##
else
	echo "7amasaDB exists already" ##
fi

