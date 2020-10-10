#!/bin/bash
if [[ $# -ne 1 ]]
then
    echo "usage: $0 <rna-pdb-file>"
else
    # initialize variable
    rna_file=$1

rna_resname=`awk -v atm="C1'" '{if(atm==$3) print $4$6}' ${rna_file} | awk 'BEGIN { ORS = ", " } { print }'`

FRAGNAM=`echo $rna_resname`
echo $FRAGNAM
#echo $FRAGNAM > temp.txt
#echo $FRAGNAM > temp.txt
#fmt -40 temp.txt > fragnames.txt
#echo $frag

fi
