#!/bin/bash

if [[ $# -ne 1 ]]
then
    echo "usage: $0 <rna-pdb-file>"
else
    if [[ ! -s ${RNAFMO} ]]
    then
        echo "\$RNAFMO variable not set"
        echo "should point to RNAFMO repo"
    else    

		# initialize variable
		rna_pdb_file=$1
    
		# make temporary folder
		tmp_dir=$(mktemp -d -t fmo-$(date +%Y-%m-%d-%H-%M-%S))
		echo "!*** temporary files located in: ${tmp_dir} ***"
		
		# copy file to temporary folder
		cp ${rna_pdb_file} ${tmp_dir}/rna.pdb
		cd ${tmp_dir}
	
		#prepars necessary files
		#FMOXYZ
		${RNAFMO}/util/1_fmoxyz_rna.sh rna.pdb > rna.xyz

		 #INDAT for rna 
		${RNAFMO}/util/2_indat_rna.sh rna.pdb > indat_temp_rna.txt 
		cat indat_temp_rna.txt | awk '{ printf "%s\n", $0}' > indat_rna.txt

		#FRAGNAM for rna 
		FRAGNAM=`${RNAFMO}/util/3_fragname_rna.sh rna.pdb | sed '$s/.$//' | fmt -w 40  |awk '{ if (NR==1) print; else printf "                 %s\n", $0}'`

		#NFRAG
		NFRAG=`grep "C1'" rna.pdb | wc -l`
		NFRAG=`echo "$NFRAG" | bc`

		#FMOBND for rna
		${RNAFMO}/util/4_fmobond_rna.sh rna.pdb > fmobnd.txt

		#Create fragments and charges
		${RNAFMO}/util/5_fragmentation_rna.sh rna.pdb fragment_starts.txt fragment_ends.txt | fmt -w 18 | sed '$s/.$//' | awk '{ if (NR==1) print; else printf "                 %s\n", $0}' > icharge_rna.txt
	
		#MAXBND = FMOBND+1
		MAXBND=`cat fmobnd.txt | wc -l`
		MAXBND=`echo "1 + $MAXBND" | bc`
	
		#GAMESS header
		cat ${RNAFMO}/inp/header.inp 
	
		#GAMESS FMO
		echo " \$FMO" 
		echo "      SCFTYP(1)=RHF"
		echo "      MODGRD=10"
		echo "      MODMUL=0"
		echo "      MAXCAO=5"
		echo "      MAXBND=$MAXBND"
		echo "      NLAYER=1"
		echo "      MPLEVL(1)=2"
		echo "      NFRAG=$NFRAG"
		echo "      ICHARG(1)= `cat icharge_rna.txt`"
		echo "      FRGNAM(1)= $FRAGNAM"
		echo "      INDAT(1)= 0"
		echo "`cat indat_rna.txt`"
		echo " \$END"
	
		#Basis set
		cat ${RNAFMO}/inp/fmohyb.inp   
	
		#FMOBND 
		if [ -s "fmobnd.txt" ]
		then
			echo " \$FMOBND"
			echo "`cat fmobnd.txt`"
			echo " \$END"
		fi  

		#FMODATA
		cat ${RNAFMO}/inp/fmodata.inp

		#FMOXYZ
		echo " \$FMOXYZ"
		echo "`cat rna.xyz`"
		echo " \$END"
    fi
fi

