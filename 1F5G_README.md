# RNAFMO
Tools for Applying FMO Calculations to RNA containing systems

## Current Limitations
- Only works for single-stranded RNA only systems
- Can't handle missing residues or non-standard PDB formatting

## Typical FMO calculation (On Gollum)

### (1) Minimize systems to remove clashes and regularize structure
```
COORS=/home/hazwong/testbed/FARFAR_DECOYS/2KOC/final_decoys/coordinates/
frames=`seq 1 1 6`
for frame in $frames
do
    /utility./prepare_database.sh 1F5G/1F5G_${frame}.pdb 1F5G 100 charmm 1  tmp/    
done
````

### (2) Generate FMO input
```
frames=`seq 1 1 6`
for frame in $frames
do
    ./rnafmo_input.sh 1F5G_${frame}_charmm.pdb > 1F5G_fmo_input_${frame}.inp
done
````

### (3) Write and submit SLURM jobs to carry out FMO calculation
```
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
