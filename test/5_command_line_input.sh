#!/bin/bash
if [[ $# -ne 1 ]]
then
	echo "usage: $0 <pdb-file>"
else
    # initialize variable
	file=$1

	cat 1_header.sh 
	./2_fmo.sh ${file}
	cat 3_fmohyb.sh 
	./4_fmoxyz.sh ${file}
fi