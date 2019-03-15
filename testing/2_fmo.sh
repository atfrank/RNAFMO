#!/bin/bash
if [[ $# -ne 1 ]]
then
	echo "usage: $0 <pdb-file>"
else
    # initialize variable
	file=$1
	
	#counts number of atoms
	ATOMS=`grep "ATOM" ${file}  | wc -l`

	#NFRAG
	#counts number of residues and prints number
	NFRAG=`grep "C1'" ${file}  | wc -l`
	

	#INDAT
	#deletes row 2, prints column 2 with C5’ and O5’, adds last row of file, adds 0 in the 
	# beginning, adds - every three rows, adds 0 every three rows, print column as row and 
	# separate with commas
	grep "ATOM" ${file} | awk -v atm1="C5'" -v atm2="O5'" '{if($2==1 || ($3==atm1 && $2>10) || 
	($3==atm2 && $2>10)) print $2}' | sed "\$a $ATOMS" |
	awk '{
	if (NR%2) 
	printf("%s   -", $0)
	else 
	printf("%s\n", $0)
	}' | sed 's/$/   0/' | sed 's/^/               /' > indat.txt
	
	#ICHARGE
	#prints -1 when column 3 shows C5’, deletes 2nd row, adds 0 at the end, print column as 
	#row and separate with commas
	awk -v atm1="C5'" '{if($3==atm1) print '-1'}' ${file} | sed '2d' | 
	sed -e "\$a0" | awk 'BEGIN { ORS = ", " } { print }' | sed '$s/..$//' | awk '{print}' | 
	fold -w40 > icharge.txt
	
	#FRGNAM
	#print number of fragments in ascending order, add “frag” in the beginning of each row, 
	#print column as row and separate with commas
	FRAGNAM=`seq $NFRAG | awk '{print "Frag" $0}' | awk 'BEGIN { ORS = ", " } { print }' | sed '$s/..$//'`
	#FMOBND
	grep "ATOM" ${file} | awk -v atm1="C5'" -v atm2="O5'" '{if(($3==atm1 && $2>10) || 
	($3==atm2 && $2>10)) print $2}' | sed -n '1~2!p' |
	awk 'BEGIN { OFS = "," } {print "   -"$0 "   " $0-1 "       3-21G    MINI"}' > fmobnd.txt
	
	#Increments NFRAG by two for MAXBND
	MAXBND=$((NFRAG+2))
	
	echo "\$FMO" 
	echo "      SCFTYP(1)=RHF"
	echo "      MODGRD=10"
	echo "      MODMUL=0"
	echo "      MAXCAO=5"
	echo "      MAXBND=$MAXBND"
	echo "      NLAYER=1"
	echo "      NFRAG=$NFRAG"
	echo "      ICHARG(1)=`cat icharge.txt`"
	echo "      FRGNAM(1)=$FRAGNAM"
	echo "      indat(1)=0"
	echo "`cat indat.txt`"
	echo " \$END"
	echo
	echo " \$FMOBND"
	echo "`cat fmobnd.txt`"
	echo " \$END"	
fi