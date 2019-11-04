#!/bin/bash
#SBATCH -p frank
#SBATCH -A frank
#SBATCH --time=168:00:00


# get current local
final_dest=`pwd`

# define variable to scratch directory
export SCRATCH=/scratch/${SLURM_JOB_USER}/${SLURM_JOB_ID}

# create local directories for GAMESS
i=${SLURM_ARRAY_TASK_ID}
mkdir -p ${SCRATCH}/2LHP_${SLURM_ARRAY_TASK_ID}/usrc ${SCRATCH}/2LHP_${SLURM_ARRAY_TASK_ID}/src
rm -rf ${SCRATCH}/2LHP_${SLURM_ARRAY_TASK_ID}/usrc/* ${SCRATCH}/2LHP_${SLURM_ARRAY_TASK_ID}/src/*

# copy need files
cp -rfv  2LHP_${i}_fmo_input.inp ${SCRATCH}/.
cp -rfv  rungms ${SCRATCH}/.
cp -rfv gms-files.csh ${SCRATCH}/.

# execute run
cd ${SCRATCH}/
./rungms 2LHP_${i}_fmo_input.inp R3 16 ${SCRATCH}/2LHP_${SLURM_ARRAY_TASK_ID}/usrc ${SCRATCH}/2LHP_${SLURM_ARRAY_TASK_ID}/src | tee 2LHP_${SLURM_ARRAY_TASK_ID}.log

cp 2LHP_${SLURM_ARRAY_TASK_ID}.log ${final_dest}/fmo_outputs/2LHP_${SLURM_ARRAY_TASK_ID}.log

#sbatch -N 1 -n 16 --job-name=fmo --exclude=gollum152 -p frank  --array=0-5 2LHP_array.sh
