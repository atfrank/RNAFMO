#!/bin/bash
#SBATCH -p frank
#SBATCH -A frank
#SBATCH --time=168:00:00

# run FMO calculation
mkdir -p 2KOC_21/gamess/usrc 2KOC_21/gamess/src
./rungms fmo_input_21.inp R3 8 /home/colltac/FMO_2KOC/2KOC_21/gamess/usrc /home/colltac/FMO_2KOC/2KOC_21/gamess/src > fmo_output_21.log

