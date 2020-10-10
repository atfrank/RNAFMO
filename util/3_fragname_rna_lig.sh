#!/bin/bash
if [[ $# -ne 2 ]]
then
    echo "usage: $0 <rna-pdb-file> <lig-pdb-file>"
else
    # initialize variable
    rna_file=$1
    lig_file=$2

#NFRAG=`grep "C1'" ${file}  | wc -l`
#for n in {1..$NFRAG}
#	do
#	`awk -v atm="C1'" '{if(atm==$3) print $4$6}' ${file}`
#	#echo ${resname}
#	done

#rna_resname=`awk -v atm="C1'" '{if(atm==$3) print $4$6}' ${rna_file} | awk 'BEGIN { ORS = ", " } { print }' | sed '$s/..$//'`
rna_resname=`awk -v atm="C1'" '{if(atm==$3) print $4$6}' ${rna_file} | awk 'BEGIN { ORS = ", " } { print }'`
lig_resname=`awk '{if(NR==1) print $4}' ${lig_file} | awk 'BEGIN { ORS = ", " } { print }'`

FRAGNAM=`echo $rna_resname $lig_resname`
echo $FRAGNAM
#echo $FRAGNAM > temp.txt
#echo $FRAGNAM > temp.txt
#fmt -40 temp.txt > fragnames.txt
#echo $frag

fi
