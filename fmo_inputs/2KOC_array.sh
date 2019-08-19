#!/bin/bash
#SBATCH -p frank
#SBATCH -A frank
#SBATCH --time=168:00:00

# run FMO calculation

# define variable to scratch directory

final_dest=`pwd`
export SCRATCH=/scratch/${SLURM_JOB_USER}/${SLURM_JOB_ID}

# create local directories for GAMESS
i=${SLURM_ARRAY_TASK_ID}
mkdir -p ${SCRATCH}/2KOC_${SLURM_ARRAY_TASK_ID}/usrc ${SCRATCH}/2KOC_${SLURM_ARRAY_TASK_ID}/src
rm -rf ${SCRATCH}/2KOC_${SLURM_ARRAY_TASK_ID}/usrc/* ${SCRATCH}/2KOC_${SLURM_ARRAY_TASK_ID}/src/*

cp -rfv  2KOC_${SLURM_ARRAY_TASK_ID}_minimized_charmm.inp ${SCRATCH}/.
cp -rfv  rungms ${SCRATCH}/.
cp -rfv gms-files.csh ${SCRATCH}/.

# execute run
cd ${SCRATCH}/
./rungms 2KOC_${SLURM_ARRAY_TASK_ID}_minimized_charmm.inp R3 14 ${SCRATCH}/2KOC_${SLURM_ARRAY_TASK_ID}/usrc ${SCRATCH}/2KOC_${SLURM_ARRAY_TASK_ID}/src | tee 2KOC_${SLURM_ARRAY_TASK_ID}.log


cp 2KOC_${SLURM_ARRAY_TASK_ID}.log ${final_dest}/fmo_outputs/2KOC_${SLURM_ARRAY_TASK_ID}.log
#  sbatch -N 1 -n 14 --job-name=fmo --exclude=gollum152 -p frank  --array=1-100 fmo_inputs/2KOC_array.sh
