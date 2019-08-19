#!/bin/bash
if [[ $# -ne 1 ]]
then
    echo "usage: $0 <pdb-file>"
else
    # initialize variable
    #module load r
    pdbFile=$1
    
    #counts number of atoms
    ATOMS=`grep "ATOM" ${pdbFile}  | wc -l`
    
    #prints start of all fragments
    awk '{print $1}' indat.txt > fragment_begins.txt

    #prints end of all fragments
    grep "ATOM" $pdbFile | awk -v atm1="C5'" -v atm2="O5'" '{if($2==1 || ($3==atm1 && $2>10) || ($3==atm2 && $2>10)) print $2}' | awk 'NR % 2 == 0' | sed "\$a $ATOMS" > fragment_ends.txt

    #prints all P atoms
    grep "ATOM" $pdbFile | awk -v atm1="P" '{if(substr($3, 0, 1)==atm1) print $2}' > P_atoms.txt
    
    #combines all three above in one file
    /export/apps/CentOS7/r/3.5.3/bin/Rscript utility/charge.R > /dev/null
    
    awk '{if($3==0) print 0; else print -1}' compare_P_and_end.txt | tr '\n' ' ' | awk '{print}'

fi
