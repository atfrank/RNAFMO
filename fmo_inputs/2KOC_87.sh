#!/bin/bash
#SBATCH -p frank
#SBATCH -A frank
#SBATCH --time=168:00:00

# run FMO calculation
rm -rf /home/afrankz/local_software/repo/RNAFMO/2KOC_87/gamess/usrc /home/afrankz/local_software/repo/RNAFMO/2KOC_87/gamess/src
mkdir -p /home/afrankz/local_software/repo/RNAFMO/2KOC_87/gamess/usrc /home/afrankz/local_software/repo/RNAFMO/2KOC_87/gamess/src
./rungms 2KOC_87_minimized_charmm.inp R3 14 /home/afrankz/local_software/repo/RNAFMO/2KOC_87/gamess/usrc /home/afrankz/local_software/repo/RNAFMO/2KOC_87/gamess/src | tee fmo_outputs/2KOC_87.log

