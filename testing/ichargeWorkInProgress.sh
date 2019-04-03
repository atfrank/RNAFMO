	#FMOBND_OLD
	sed '2d' ${file} | awk -v atm1="C5'" -v atm2="O5'" '{if($3==atm1 || 
	$3==atm2) print $2}' | sed -n '1~2!p' | awk '{print $1, "  ", $2 = $1 + 1, "  ", $3 = "3-21G", "  ", $4 = "MINI"}'| awk '{print "      -"$0}' > fmobnd.txt
	
	
	#FMOBND
	sed '2d' 2LDT_nlb_decoy_5.pdb  | awk -v atm1="C5'" -v atm2="O5'" '{if($3==atm1 || $3==atm2) print $2}' | 
	awk '{print $1, "  ", $2 = $1 + 1, "  ", $3 = "3-21G", "  ", $4 = "MINI"}'| 
	awk '{print "      -"$0}' > fmobnd.txt
	
	grep "ATOM" 2LDT_nlb_decoy_5.pdb | awk -v atm1="C5'" -v atm2="O5'" '{if(($3==atm1 && $2>10) || 
	($3==atm2 && $2>10)) print $2}' | sed -n '1~2!p' | awk -v atm=$0 '{print "-"$0 " "$atm}' |sed 's/$/   3-21G   MINI/' > fmobnd.txt
	
	
	awk -v atm1="C5'" '{if($3==atm1) print '-1'}' 2LDT_nlb_decoy_5.pdb | sed '2d' | sed -e "\$a0" | awk 'BEGIN { ORS = ", " } { print }' | sed '$s/..$//' | awk '{print}' | 
	fold -w40 > icharge.txt
	
	#####################################################################################

	
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

	while IFS=, read col1 col2 col3; do {if($col3 < $col2 && $col3 > $col1){x=-1}} print x {else{x=0}} print x; done < compare_P_and_end.txt


	#dr. frank notes

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
	
	#####################################################################################
	
	declare -i numFrags=0
	declare -i zero=0
	declare -i div=0
	declare -i mod=0
	declare -i j=0
	declare -i k=0
	negOneStr="-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, /n"
	negOneStrSpaces="                -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, /n"
	negOneSingle="-1, "
	endChars=" 0"
	
	
	
	
	
	
	#ICHARGE
	awk -v atm1="C5'" '{if($3==atm1) let "numFrags++"}' ${file} | sed '2d' | 
	sed -e "\$a0" | awk 'BEGIN { ORS = ", " } { print }' | sed '$s/..$//' | awk '{print}' | 
	fold -w40 > icharge.txt
	
	
	
	
	awk -v atm1="C5'" '{if($3==atm1) let "numFrags++"}' 2LDT_nlb_decoy_5.pdb | 
	awk negOneStr="-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, " '{if(numFrags>=10) print negOneStr'
	
	awk -v atm1="C5'" '{if($3==atm1) let "numFrags++"}' 2LDT_nlb_decoy_5.pdb | 
	{if(numFrags>=10) 
		print negOneStr
		div=numFrags / 10
		for j in div
			do print negOneStrSpaces
			let "j++"
		done 
		mod=numFrags % 10
		for k in mod
			doprint negOneSingle
			let "k++"
		done 
		print endChars}
		
	{if(numFrags<10)
		for j in numFrags
			do print}
			
	
	
	
	
	
	
	sed '2d' | 
	sed -e "\$a0" | awk 'BEGIN { ORS = ", " } { print }' | sed '$s/..$//' | awk '{print}' | 
	fold -w40 > icharge.txt
	
	
	
	'{if($3==atm1 || $3==atm2) print $2}'
	
	
	
	
	
	
	
	
	
	
	