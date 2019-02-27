#!/bin/bash
if [[ $# -ne 1 ]]
then
	echo "usage: $0 <pdb-file>"
else
    # initialize variable
	file=$1
	
echo " \$FMOXYZ" 
awk '{if ($2 < 10) print "   ", $2, "  ", $13, "  ", $7, "  ", $8, "  ", $9}' ${file}
awk '{if ($2 < 100 && $2 >= 10) print "  ", $2, "  ", $13, "  ", $7, "  ", $8, "  ", $9}' ${file}
awk '{if ($2 < 1000 && $2 >= 100) print " ", $2, "  ", $13, "  ", $7, "  ", $8, "  ", $9}' ${file}
echo " \$END" 
fi
