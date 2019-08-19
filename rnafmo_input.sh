#!/bin/bash
if [[ $# -ne 1 ]]
then
    echo "usage: $0 <pdb-file>"
else
    # initialize variable
    file=$1
    
    if [[ ! -s ${RNAFMO} ]]
    then
        echo "\$RNAFMO variable not set"
    else    
        # remove old tmp files
        mkdir -p tmp/
        rm -rf indat.txt icharge.txt fmobnd.txt fmobnd.txt indat.txt icharge.txt fragment_ends.txt fragment_begins.txt compare_P_and_end.txt P_atoms.txt
    
        # get GAMESS header
        cat ${RNAFMO}/include/header.inp 
    
        # parse input pdb and get info and files needed to write custom FMO input
        ${RNAFMO}/utility/./fmo.sh ${file}
    
        # add basis set info
        cat ${RNAFMO}/include/fmohyb.inp 
    
        # get coordinates
        ${RNAFMO}/utility/./fmoxyz.sh ${file} | awk '{if(NF>0) print}'
    
        # move tmp files
        mv fmobnd.txt tmp/.
        mv indat.txt tmp/.
        mv icharge.txt tmp/.
        mv fragment_ends.txt tmp/.
        mv fragment_begins.txt tmp/.
        mv compare_P_and_end.txt tmp/.
        mv P_atoms.txt tmp/.
    fi
fi