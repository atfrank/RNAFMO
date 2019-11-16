#!/bin/bash
#SBATCH -p frank
#SBATCH --time=168:00:00

# run FMO calculation
mkdir -p 2KOC_1/gamess/usrc 2KOC_1/gamess/src
./rungms fmo_input_1.inp R3 8 /home/colltac/FMO_2KOC/2KOC_1/gamess/usrc /home/colltac/FMO_2KOC/2KOC_1/gamess/src | tee fmo_output_1.log

