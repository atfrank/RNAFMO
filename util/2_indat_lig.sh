#!/bin/bash
if [[ $# -ne 1 ]]
then
    echo "usage: $0 <pdb-file>"
else
    # initialize variable
    file=$1
    
start=`sed -n "1p" $file | awk '{print $2}'`
lines=`cat lig.pdb | wc -l`
end=`sed -n "${lines}p" $file | awk '{print $2}'`

#echo "${start} -${end} 0"
printf "%16s""${start} -${end} 0\n"
fi
