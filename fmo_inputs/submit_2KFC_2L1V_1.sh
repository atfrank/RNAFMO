#!/bin/bash
#SBATCH -p frank
#SBATCH -A frank
#SBATCH --time=168:00:00

# run FMO calculation
rm -rf /home/afrankz/local_software/repo/RNAFMO/2KFC_2L1V_1/gamess/usrc /home/afrankz/local_software/repo/RNAFMO/2KFC_2L1V_1/gamess/src
mkdir -p /home/afrankz/local_software/repo/RNAFMO/2KFC_2L1V_1/gamess/usrc /home/afrankz/local_software/repo/RNAFMO/2KFC_2L1V_1/gamess/src

