#!/bin/bash
if [[ $# -ne 3 ]]
then
		echo "  Description: downloads and then writes out individual models of a PDB "
		echo "  Usage: $0 < PDBID > < output file prefix > < numbering offset >"        
		echo "  Usage: $0 1SCL model_ 0"        
else
	PDB=$1
	outputname=$2
	offset=$3
  source ~/.bashrc
  # Download PDB
	downloadPDB ${PDB} > /dev/null
	# Count number of models using catdcd
	models=`catdcd -pdb ${PDB}.pdb | tail -2 | head -1 | awk '{print $3}'`	
	echo "${PDB} contains ${models} models"
	# Create sequence of model numbers
	models=`seq 1 ${models}`	
	# Loop over models and write out individual PDBs
	for i in $models
	do
		model=$((i+offset))
		catdcd -o ${outputname}_${model}.pdb -otype pdb -s ${PDB}.pdb -stype pdb -first ${i} -last ${i} -pdb ${PDB}.pdb > /dev/null
	done
	# Clean up
	rm ${PDB}.pdb
fi
