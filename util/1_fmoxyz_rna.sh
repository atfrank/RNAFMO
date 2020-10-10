#!/bin/bash
if [[ $# -ne 1 ]]
then
    echo "usage: $0 <pdb-file>"
else
    # XYZ file
    file=$1
    grep "ATOM" ${file} > temp.pdb
    #echo " \$FMOXYZ" 
    #awk '{if ($2 < 10000) print "   ", $2, "  ", substr($3,0,1), "  ", $7, "  ", $8, "  ", $9}' temp.pdb | sed '$d'
    awk '{if ($2 < 10000) print "   ", $2, "  ", substr($3,0,1), "  ", $7, "  ", $8, "  ", $9}' temp.pdb
    #echo " \$END" 
    rm temp.pdb
fi
