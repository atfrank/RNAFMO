#!/bin/bash
if [[ $# -ne 1 ]]
then
    echo "usage: $0 <pdb-file>"
else
    # initialize variable
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
    pr -mts' ' fragment_begins.txt fragment_ends.txt P_atoms.txt > compare_P_and_end.txt
    
    awk '{if(NF==3) print -1; else print 0}' compare_P_and_end.txt | tr '\n' ' ' | awk '{print}'

fi
