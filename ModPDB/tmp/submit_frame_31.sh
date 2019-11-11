#!/bin/bash
#SBATCH -p frank
#SBATCH -A frank
#SBATCH --time=168:00:00

# run FMO calculation
mkdir -p 2KOC_31/gamess/usrc 2KOC_31/gamess/src
./rungms fmo_input_31.inp R3 8 /home/colltac/FMO_2KOC/2KOC_31/gamess/usrc /home/colltac/FMO_2KOC/2KOC_31/gamess/src > fmo_output_31.log

