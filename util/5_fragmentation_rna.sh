#!/bin/bash
if [[ $# -ne 3 ]]
then
    echo "usage: $0 <rna-pdb-file> <fragment_starts.txt> <fragment_ends.txt>>"
else
    # initialize variable
    rna=$1
    starts=$2
    ends=$3

nfrag=`cat $starts | wc -l`
#echo $nfrag
for f in $(seq 1 $nfrag)
        do
	start=`awk -v atm22="$f" '{if(NR==atm22) print $1}' ${starts}`
	end=`awk -v atm22="$f" '{if(NR==atm22) print $1}' ${ends}`
	#echo "$start $end"
        awk -v s="$start" -v e="$end" 'NR>=s && NR<=e' ${rna} > frag${f}.pdb 
	if  grep -q 'H5T|H3T' frag${f}.pdb
	then
		echo -n "0, "
	elif grep -q 'H3T' frag${f}.pdb
	then
		echo -n "0, "
	else grep -q 'P' frag${f}.pdb
		echo -n "-1, "
	fi
        done
echo ""
fi

#./fragmentation.sh rna.pdb fragment_starts.txt fragment_ends.txt | sed '$s/..$//' | fmt -w 20
