#!/bin/bash
if [[ $# -ne 1 ]]
then
	echo "usage: $0 <pdb-file>"
else
    # initialize variable
	file=$1
	
echo " \$FMOXYZ" 
awk '{if ($2 < 10000) print "   ", $2, "  ", substr($3,0,1), "  ", $7, "  ", $8, "  ", $9}' ${file} | sed '$d'
echo " \$END" 
fi
