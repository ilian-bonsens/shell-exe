if [ $2 = "+" ]; then
	expr $1 + $3
	echo $expr

elif [ $2 = "-" ]; then
	expr $1 - $3
	echo $expr

elif [ $2 = "x" ]; then
	expr $1 \* $3
	echo $expr

elif [ $2 = "/" ]; then
	expr $1 / $3
	echo $expr
fi
