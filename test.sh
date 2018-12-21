read colVal
read constraint
#echo $colVal
#echo $constraint
echo
echo
	
if [ ! $colVal ] 
then
	echo "not null"
	flag=0
else
	if [ "$constraint" = "5" ]
	then
		echo constraint
	else
		echo not
	fi
fi
