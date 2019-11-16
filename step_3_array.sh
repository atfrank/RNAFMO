#!/bin/bash
#SBATCH -p frank
#SBATCH -A frank
#SBATCH --time=168:00:00

molecule="1SZY"

# get current local
final_dest=`pwd`

# define variable to scratch directory
export SCRATCH=/scratch/${SLURM_JOB_USER}/${SLURM_JOB_ID}

# create local directories for GAMESS
i=${SLURM_ARRAY_TASK_ID}
mkdir -p ${SCRATCH}/${molecule}_${SLURM_ARRAY_TASK_ID}/usrc ${SCRATCH}/${molecule}_${SLURM_ARRAY_TASK_ID}/src
rm -rf ${SCRATCH}/${molecule}_${SLURM_ARRAY_TASK_ID}/usrc/* ${SCRATCH}/${molecule}_${SLURM_ARRAY_TASK_ID}/src/*

# copy need files
cp -rfv  ${molecule}_${i}_fmo_input.inp ${SCRATCH}/.
cp -rfv  rungms ${SCRATCH}/.
cp -rfv gms-files.csh ${SCRATCH}/.

# execute run
cd ${SCRATCH}/
./rungms ${molecule}_${i}_fmo_input.inp R3 16 ${SCRATCH}/${molecule}_${SLURM_ARRAY_TASK_ID}/usrc ${SCRATCH}/${molecule}_${SLURM_ARRAY_TASK_ID}/src | tee ${molecule}_${SLURM_ARRAY_TASK_ID}.log

cp ${molecule}_${SLURM_ARRAY_TASK_ID}.log ${final_dest}/fmo_outputs/${molecule}_${SLURM_ARRAY_TASK_ID}.log

#sbatch -N 1 -n 8 --job-name=fmo --exclude=gollum152 -p frank --array=1-5 
