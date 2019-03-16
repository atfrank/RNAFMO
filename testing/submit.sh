#!/bin/bash
#SBATCH -p frank
#SBATCH -A frank
#SBATCH --time=168:00:00
#SBATCH --ntasks=8

rna=$1
model=${SLURM_ARRAY_TASK_ID}
if  [[ -f ../test/pdbs/${rna}_nlb_decoy_${model}.pdb  ]]
then
    # prepare GAMESS input script
    ./5_command_line_input.sh ../test/pdbs/${rna}_nlb_decoy_${model}.pdb > ${rna}_nlb_decoy_${model}.inp

    # run GAMESS calculation
    mkdir -p ${rna}/gamess/usrc_${model} ${rna}/gamess/src_${model}
    ./rungms ${rna}_nlb_decoy_${model}.inp R3 8 /home/hazwong/test/git_repository/RNAFMO/testing/${rna}/gamess/usrc_${model} /home/hazwong/test/git_repository/RNAFMO/testing/${rna}/gamess/src_${model}/ > ${rna}_nlb_decoy_${model}.log 
fi

# submit: sbatch --array=1-100%25 -N1 -p frank submit.sh 1XHP
# cancel: scancel XXXXX
# check: sq
# more information on using SLURM see: https://slurm.schedmd.com/tutorials.html