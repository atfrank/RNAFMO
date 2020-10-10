#!/bin/bash
if [[ $# -ne 1 ]]
then
    echo "usage: $0 <pdb-file>"
else
    # initialize variable
    file=$1

rm -rf fragment_starts.txt || true
rm -rf fragment_ends.txt || true
    
h5t=`awk -v atm11="H5T" '{if($2==1 && $3==atm11) print $2}' $file`
#echo ${h5t}
h3ts=`awk -v atm22="H3T" '{if($2>1 && $3==atm22) print $2}' $file`
#echo ${h3ts}
fields1=`echo ${h3ts} | awk '{print NF}'`
#echo ${fields}
#for f in `eval echo {1..$fields1}`
for f in $(seq 1 $fields1)
	do
	#echo $f
	h3t=`echo ${h3ts} | awk -v itr="${f}" '{print $itr}'`
	awk -v s="$h5t" -v e="$h3t" 'NR>=s && NR<=e' ${file} > truncated${f}.pdb	
	c1=`grep "C1'" truncated${f}.pdb  | wc -l`
	#echo ${c1}
	if (( ${c1} > 1 ))
	then
		#echo "truncated${f}.pdb"	
		#ATOMS=`grep "ATOM" truncated${f}.pdb  | wc -l`
		o5s=`grep "ATOM" truncated${f}.pdb | awk -v atm1="O5'" '{if($3==atm1) print $2}' | awk -v s=2 'NR>=s'`
		start=`awk '{if(NR==1) print $2}' truncated${f}.pdb`
		lines=`cat truncated${f}.pdb | wc -l`
                end=`sed -n "${lines}p" truncated${f}.pdb | awk '{print $2}'`
		fields=`echo ${o5s} | awk '{print NF}'`
		#for g in `eval echo {1..$fields}`
		for g in $(seq 1 $fields)
			do
			o5=`echo ${o5s} | awk -v itr1="${g}" '{print $itr1}'`
			#echo "${start} -${o5} 0"
			printf "%16s""${start} -${o5} 0\n"
			echo "${start}" >> fragment_starts.txt
			echo "${o5}" >> fragment_ends.txt
			start=`echo "1 + ${o5}" | bc`
			#echo "${start}  -${ATOMS} 0"
			done
		#echo "${start} -${end} 0"
		printf "%16s""${start} -${end} 0\n"
		echo "${start}" >> fragment_starts.txt
                echo "${end}" >> fragment_ends.txt
	else
		start1=`sed -n "1p" truncated${f}.pdb | awk '{print $2}'`
		lines1=`cat truncated${f}.pdb | wc -l`
		end1=`sed -n "${lines1}p" truncated${f}.pdb | awk '{print $2}'`
		#echo "${start1} -${end1} 0"
		printf "%16s""${start1} -${end1} 0\n"
		echo "${start1}" >> fragment_starts.txt
                echo "${end1}" >> fragment_ends.txt
	fi
	#echo "${start}  -${ATOMS} 0" 
	h5t=`echo "1 + $h3t" | bc`
	done
fi
