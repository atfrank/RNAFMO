	pdbFile=2LDT_nlb_decoy_5.pdb
	#counts number of atoms
	ATOMS=`grep "ATOM" ${pdbFile}  | wc -l`
	
	#prints start of all fragments
	awk '{print $1}' indat.txt > fragment_begins.txt

	#prints end of all fragments
	grep "ATOM" $pdbFile | awk -v atm1="C5'" -v atm2="O5'" '{if($2==1 || ($3==atm1 && $2>10) || ($3==atm2 && $2>10)) print $2}' | awk 'NR % 2 == 0' | sed "\$a $ATOMS" > fragment_ends.txt

	#prints all P atoms
	grep "ATOM" $pdbFile | awk -v atm1="P" '{if($13==atm1) print $2}' > P_atoms.txt
	
	#combines all three above in one file
	pr -mts' ' fragment_begins.txt fragment_ends.txt P_atoms.txt > compare_P_and_end.txt
	
	awk '{if(NF==3) print -1; else print 0}' compare_P_and_end.txt | tr '\n' ' ' | awk '{print}'
	exit

	#syntax error?
	while IFS=, read $1 $2 $3; do {if($3 < $2 && $3 > $1){x=-1}} print x {else{x=0}} print x; done < compare_P_and_end.txt

	awk -v frg1=1 -v frg2=36 '{if($2<=frg2 && $2>=frg1)print}' $pdbFile | awk '{ if($3=="P")print "P-present"; else print "no-P"}'

	#print line 1
	awk -v line=1 '{if (NR==line) print}' $pdbFile
	frg1=`awk -v line=1 '{if (NR==line) print $1}' $pdbFile`
	frg2=`awk -v line=1 '{if (NR==line) print $2}' $pdbFile`
	#count number of lines in a file
	lines=`wc -l $pdbFile | awk '{print $1}'`
	#create a set of numbers that go between 1-lines
	lines=`seq 1 $lines`
	for line in $lines; do echo "$line"; done