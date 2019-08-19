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
mkdir -p ${SCRATCH}/2LX1_${SLURM_ARRAY_TASK_ID}/usrc ${SCRATCH}/2LX1_${SLURM_ARRAY_TASK_ID}/src
rm -rf ${SCRATCH}/2LX1_${SLURM_ARRAY_TASK_ID}/usrc/* ${SCRATCH}/2LX1_${SLURM_ARRAY_TASK_ID}/src/*

# copy need files
cp -rfv  2LX1_${SLURM_ARRAY_TASK_ID}_minimized_charmm.inp ${SCRATCH}/.
cp -rfv  rungms ${SCRATCH}/.
cp -rfv gms-files.csh ${SCRATCH}/.

# execute run
cd ${SCRATCH}/
./rungms 2LX1_${SLURM_ARRAY_TASK_ID}_minimized_charmm.inp R3 16 ${SCRATCH}/2LX1_${SLURM_ARRAY_TASK_ID}/usrc ${SCRATCH}/2LX1_${SLURM_ARRAY_TASK_ID}/src | tee 2LX1_${SLURM_ARRAY_TASK_ID}.log

cp 2LX1_${SLURM_ARRAY_TASK_ID}.log ${final_dest}/fmo_outputs/2LX1_${SLURM_ARRAY_TASK_ID}.log

sbatch -N 1 -n 16 --job-name=fmo --exclude=gollum152 -p frank  --array=0-5 2LX1_array.sh