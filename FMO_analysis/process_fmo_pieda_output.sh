#!/bin/bash
if [[ $# -ne 1 ]]
then
    echo "usage: $0 /path/to/GAMESS/FMO-PIEDA/output/file"
else
    # initialize variable
    file=$1
    awk '/I    J DL  Z    R/{f=1;next} / Total energy of the molecule: Ecorr  /{f=0} f'  ${file}  | grep -v "\-\-\-\-" | grep . 
fi
