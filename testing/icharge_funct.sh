	#!/bin/bash
if [[ $# -ne 1 ]]
then
	echo "usage: $0 <pdb-file>"
else
    # initialize variable
	file=$1
	
	declare -i numFrags=0
	declare -i zero=0
	declare -i div=0
	declare -i mod=0
	declare -i j=0
	declare -i k=0
	negOneStr="-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, /n"
	negOneStrSpaces="                -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, /n"
	negOneSingle="-1, "
	endChars=" 0"
	atm1="C5'"
	
	if [$3==atm1]
	then
		let "numFrags++"
	fi
	
	if [$numFrags>=10]
	then
		echo "$negOneStr"
		div=$numFrags / 10
		for j in div
			do 
				echo "$negOneStrSpaces"
				let "j++"
		done 
		mod=numFrags % 10
		for k in mod
			do
				echo "$negOneSingle"
				let "k++"
		done 
		echo "$endChars"
	fi
		
	if[numFrags<10]
		for j in numFrags
			do 
				echo echo "$negOneSingle"
				let "k++"
		done 
		echo "$endChars"
	fi
			
			
fi