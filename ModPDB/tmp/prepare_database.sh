#!/bin/bash
# Script to generate CHARMM and AMBER STRUCTURE files
# Author: Aaron T. Frank
# Date: 07/11/2016
if [[ $# -ne 6 ]]
then
	echo "usage: $0 <path/to/pdb> <output_prefix> <minimization steps> <amber, charmm, or both> <verbose=1> <path/to/tmp/directory>"
	exit
else
	PDB=$1
	OUTPUT_PREFIX=$2
	NSTEPS=$3
	WHICH=$4
	VERBOSE=$5
        TMP=$6
	
	[[ $WHICH == "both" || $WHICH == "amber" || $WHICH == "AMBER" ]] && AMBER=1
	[[ $WHICH == "both" || $WHICH == "charmm" || $WHICH == "CHARMM" ]] && CHARMM=1
	
	if [[ ${VERBOSE} == 1 ]]
	then
		echo "This script will generate:"
		echo "(1) AMBER: ${OUTPUT_PREFIX}.prmtop"
		echo "(2) AMBER: ${OUTPUT_PREFIX}.pdb"
		echo "(3) AMBER: ${OUTPUT_PREFIX}.mol2"
		echo "(4) CHARMM: ${OUTPUT_PREFIX}.psf"
		echo "(5) CHARMM: ${OUTPUT_PREFIX}.pdb"
		echo "(6) CHARMM: ${OUTPUT_PREFIX}.crd"
	fi
fi

#load necessary environment variables
source ~/.bashrc
module load mmtsb
module load charmm
module load amber/16tools

#write out generic tleap file
cat << EOF >|  ${TMP}/pretleap
addPath /home/afrankz/new_amber_parameters/ff99bsc0chiOL
addPath /home/afrankz/new_amber_parameters/modifed_bases/
addPath /home/afrankz/local_software/repo/amber14/dat/leap/cmd/oldff/
source leaprc.ff99bsc0 
loadamberprep all_nuc94_ol_bsc0.in  
loadamberparams frcmod.ol.dat  
source modified.bases.load
addPdbResMap {
{ 0 "GUA" "RG5" } { 1 "GUA" "RG3" } { "GUA" "RG" }
{ 0 "ADE" "RA5" } { 1 "ADE" "RA3" } { "ADE" "RA" }
{ 0 "URA" "RU5" } { 1 "URA" "RU3" } { "URA" "RU" }
{ 0 "CYT" "RC5" } { 1 "CYT" "RC3" } { "CYT" "RC" }
{ 0 "CBV" "RC5" } { 1 "CBV" "RC3" } { "CBV" "RC" }
{ 0 "CG1" "RG5" } { 1 "CG1" "RG3" } { "CG1" "RG" }
{ 0 "DPR" "PRO" } { 1 "DPR" "PRO" } { "DPR" "PRO" }
}
nucleic= loadPdb ${TMP}/rna.pdb 
saveAmberParm  nucleic ${TMP}/rna_amber.prmtop ${TMP}/rna_amber.crd  
savePdb  nucleic ${TMP}/rna_amber.pdb 
savemol2  nucleic ${TMP}/rna_amber.mol2 1
quit 
EOF

# Get initial PDB
convpdb.pl -out amber "" -nsel heavy ${PDB} > ${TMP}/rna.pdb

# prepare AMBER system
if [[ ${AMBER} == "1" ]]
then
	if [[ ${VERBOSE} == "1" ]]
	then
		tleap -f ${TMP}/pretleap
		minab ${TMP}/rna_amber.pdb ${TMP}/rna_amber.prmtop ${TMP}/rna_amber_min.pdb 2 $NSTEPS '::P*,O*,C*,N*' 0.1
	else
		tleap -f ${TMP}/pretleap >& ${TMP}/pretleap.out
		minab ${TMP}/rna_amber.pdb ${TMP}/rna_amber.prmtop ${TMP}/rna_amber_min.pdb 2 $NSTEPS '::P*,O*,C*,N*' 0.1 >& ${TMP}/minab.out
	fi
	mv ${TMP}/rna_amber.prmtop ${OUTPUT_PREFIX}_amber.prmtop
	mv ${TMP}/rna_amber_min.pdb ${OUTPUT_PREFIX}_amber.pdb
	mv ${TMP}/rna_amber.mol2 ${OUTPUT_PREFIX}_amber.mol2
fi

# prepare CHARMM system
if [[ ${CHARMM} == "1" ]]
then
	minCHARMM.pl -par nodeoxy,sdsteps=$NSTEPS,minsteps=0,gb,cuton=10,cutoff=12,cutnb=15 -cons heavy self 1:99999_0.5 -elog ener.log -cmd ener.inp ${TMP}/rna.pdb > ${OUTPUT_PREFIX}_charmm.pdb
	genPSF.pl -par nodeoxy -crdout ${OUTPUT_PREFIX}_charmm.crd ${OUTPUT_PREFIX}_charmm.pdb > ${OUTPUT_PREFIX}_charmm.psf
	if [[ ${VERBOSE} == "1" ]]
	then
		cat ener.log
	fi
fi
