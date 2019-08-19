#!/bin/bash
if [[ $# -ne 3 ]]
then
    echo "usage: $0 <pdbid> <frames> <base-path-to-coordinates>"
else
    # initialize variable
    pdb=$1
    frames=$2
    export COORS=$3
    export RNAFMO=/home/afrankz/local_software/repo/RNAFMO
    
    for frame in $frames
    do
        rna=${pdb}_${frame}
        cur=`pwd`
        
        # minimize structure
        ${RNAFMO}/utility/./prepare_database.sh ${COORS}/${rna}.pdb ${COORS}/${rna}_minimized 100 charmm 1  tmp/
        
        # Prepare fmo input file
        ${RNAFMO}/./rnafmo_input.sh ${COORS}/${rna}_minimized_charmm.pdb > ${rna}_minimized_charmm.inp
        
        # Write SLURM script
        echo '#!/bin/bash' >  fmo_inputs/${rna}.sh 
        echo "#SBATCH -p frank" >> fmo_inputs/${rna}.sh 
        echo "#SBATCH -A frank" >> fmo_inputs/${rna}.sh 
        echo "#SBATCH --time=168:00:00" >> fmo_inputs/${rna}.sh 
        echo "" >> fmo_inputs/${rna}.sh 
        echo "# run FMO calculation" >> fmo_inputs/${rna}.sh 
        echo "rm -rf ${cur}/${rna}/gamess/usrc ${cur}/${rna}/gamess/src" >> fmo_inputs/${rna}.sh 
        echo "mkdir -p ${cur}/${rna}/gamess/usrc ${cur}/${rna}/gamess/src" >> fmo_inputs/${rna}.sh 
        echo "./rungms ${rna}_minimized_charmm.inp R3 14 ${cur}/${rna}/gamess/usrc ${cur}/${rna}/gamess/src | tee fmo_outputs/${rna}.log" >> fmo_inputs/${rna}.sh 
        echo "" >> fmo_inputs/${rna}.sh
        #bash fmo_inputs/${rna}.sh
    
        # Submit SLURM script
        # sbatch -N 1 -n 14  --job-name=${rna} --exclude=gollum152 -p frank fmo_inputs/${rna}.sh
    done
fi