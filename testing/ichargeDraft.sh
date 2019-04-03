	#prints start of all fragments
	awk '{print $1}' indat.txt > fragment_begins.txt

	#prints end of all fragments
	grep "ATOM" 2LDT_nlb_decoy_5.pdb | 
	awk -v atm1="C5'" -v atm2="O5'" '{if($2==1 || ($3==atm1 && $2>10) || ($3==atm2 && $2>10)) print $2}' |
	awk 'NR % 2 == 0' | sed "\$a $ATOMS" > fragment_ends.txt

	#prints all P atoms
	grep "ATOM" 2LDT_nlb_decoy_5.pdb | awk -v atm1="P" '{if($13==atm1) print $2}' > P_atoms.txt

	#combines all three above in one file
	pr -mts' ' fragment_begins.txt fragment_ends.txt P_atoms.txt > compare_P_and_end.txt

	awk -n '{if($3 < $2 && $3 > $1) print -1}' compare_P_and_end.txt /etc/passwd

	#syntax error?
	while IFS=, read $1 $2 $3; do {if($3 < $2 && $3 > $1){x=-1}} print x {else{x=0}} print x; done < compare_P_and_end.txt



	awk -v frg1=1 -v frg2=36 '{if($2<=frg2 && $2>=frg1)print}' 1XHP_nlb_decoy_1.pdb | awk '{ if($3=="P")print "P-present"; else print "no-P"}'

	#print line 1
	awk -v line=1 '{if (NR==line) print}' 1XHP_nlb_decoy_1.pdb
	frg1=`awk -v line=1 '{if (NR==line) print $1}' 1XHP_nlb_decoy_1.pdb`
	frg2=`awk -v line=1 '{if (NR==line) print $2}' 1XHP_nlb_decoy_1.pdb`
	#count number of lines in a file
	lines=`wc -l 1XHP_nlb_decoy_1.pdb | awk '{print $1}'`
	#create a set of numbers that go between 1-lines
	lines=`seq 1 $lines`
	for line in $lines; do echo "$line"; done