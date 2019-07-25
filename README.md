# RNAFMO
Tools for Applying FMO Calculations to RNA containing systems

## Current Limitation
- Only tested on single stranded RNA only systems
- Can't handle missing residues or non-standard PDB formatting

## Typical FMO calculation

```
# (1) minimize and (2) generate FMO input
COORS=/home/afrankz/testbed/FARFAR_DECOYS/2KOC/final_decoys/coordinates/

# (1) minimize
frames=`seq 1 10 50`
for frame in $frames
do
    /utility./prepare_database.sh ${COORS}/decoy_${frame}.pdb decoy_${frame} 100 charmm 1  tmp/    
done

# (2) generate FMO input
frames=`seq 1 10 50`
for frame in $frames
do
    
    ./rnafmo_input.sh decoy_${frame}_charmm.pdb > fmo_input_${frame}.inp
done

# (3) run FMO calculation
frames=`seq 1 10 50`
for frame in $frames
do
    # Write SLURM script
    rna=2KOC_${frame}
    echo '#!/bin/bash' >  submit_frame_${frame}.sh 
    echo "#SBATCH -p frank" >> submit_frame_${frame}.sh 
    echo "#SBATCH -A frank" >> submit_frame_${frame}.sh 
    echo "#SBATCH --time=168:00:00" >> submit_frame_${frame}.sh 
    echo "" >> submit_frame_${frame}.sh 
    echo "# run FMO calculation" >> submit_frame_${frame}.sh 
    echo "mkdir -p ${rna}/gamess/usrc ${rna}/gamess/src" >> submit_frame_${frame}.sh 
    echo "./rungms fmo_input_${frame}.inp R3 14 /home/colltac/FMO_2KOC/${rna}/gamess/usrc /home/colltac/FMO_2KOC/${rna}/gamess/src > fmo_output_${frame}.log" >> submit_frame_${frame}.sh 
    echo "" >> submit_frame_${frame}.sh 
    
    # Submit SLURM script
    sbatch -N 1 -n 14 --exclude=gollum152 -p frank submit_frame_${frame}.sh  
done

````