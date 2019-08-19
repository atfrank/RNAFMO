#!/bin/bash

# run jobs
for i in {2..2}
do
    rm -rfv 2KOC_${i}
    if [[ ! -f 2KOC_${i}.log ]]
    then
        done=`grep "EXECUTION OF GAMESS TERMINATED NORMALLY" fmo_outputs/2KOC_${i}.log`
        if [[ ! -z ${done} ]]
        then
            echo $done $i
        else 
            sbatch -N 1 --ntasks-per-node=14  --job-name=fmo_${i} --exclude=gollum152 -p frank fmo_inputs/2KOC_${i}.sh
            sleep 2
        fi
    else
        sbatch -N 1 --ntasks-per-node=14 --job-name=fmo_${i} --exclude=gollum152 -p frank fmo_inputs/2KOC_${i}.sh
        sleep 2
    fi
done


