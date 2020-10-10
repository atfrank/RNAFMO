#!/bin/bash

if [[ $# -ne 2 ]]
then
    echo "usage: $0 <lig-pdb-file> <lig-charge>"
else
    if [[ ! -s ${RNAFMO} ]]
    then
        echo "\$RNAFMO variable not set"
        echo "should point to RNAFMO repo"
    else    
		# initialize variable
		lig_pdb_file=$1
		lig_charge=$2
	
		# make temporary folder
		tmp_dir=$(mktemp -d -t fmo-$(date +%Y-%m-%d-%H-%M-%S))
		echo "!*** temporary files located in: ${tmp_dir} ***"
		
		# copy file to temporary folder
		cp ${lig_pdb_file} ${tmp_dir}/lig.pdb
		cd ${tmp_dir}
	
		#prepars necessary files
		#FMOXYZ
		${RNAFMO}/util/1_fmoxyz_lig.sh lig.pdb > lig.xyz

		ligatoms=`cat lig.xyz | wc -l | bc`
		awk '{print "    "$2"    "$3"    "$4"    "$5}' lig.xyz > coor.txt
		seq 1 $ligatoms | awk '{print "    "$1}' > coor_lig_index.txt
		paste coor_lig_index.txt coor.txt > lig_indexed.xyz

		 #INDAT for ligand
		echo "                1 -$ligatoms 0" > indat_lig_indexed.txt 

		#FRAGNAM ligand
		FRAGNAM=`awk '{if(NR==1) print $4}' lig.pdb`

		#NFRAG
		NFRAG=1

		ICHARGE=$lig_charge

		MAXBND=1
	
		#GAMESS header
		cat ${RNAFMO}/inp/header_lig.inp 
	
		#GAMESS FMO
		echo " \$FMO" 
		echo "      SCFTYP(1)=RHF"
		echo "      MODGRD=10"
		echo "      MODMUL=0"
		echo "      NBODY=1"
		echo "      MAXCAO=5"
		echo "      MAXBND=$MAXBND"
		echo "      NLAYER=1"
		echo "      MPLEVL(1)=2"
		echo "      NFRAG=$NFRAG"
		echo "      ICHARG(1)= $lig_charge"
		echo "      FRGNAM(1)= $FRAGNAM"
		echo "      INDAT(1)= 0"
		echo "`cat indat_lig_indexed.txt`"
		echo " \$END"
	
		#Basis set
		cat ${RNAFMO}/inp/fmohyb.inp   

		#FMODATA
		cat ${RNAFMO}/inp/fmodata.inp

		#FMOXYZ
		echo " \$FMOXYZ"
		echo "`cat lig_indexed.xyz`"
		echo " \$END"
    fi        
fi

