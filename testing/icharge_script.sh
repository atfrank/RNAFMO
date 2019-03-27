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









do
	if ($3 < $2 && $3 > $1)
		x = -1
		print x
	else
		x = 0
		print x
done < compare_P_and_end.txt

awk '{
	x=0
	for(i=1;i<NF;i++) {
		if ($i > $(i+1)) {
			x=-1
			print x
		}
		else {
			x=0
			print x
		}
	}
}' compare_P_and_end.txt











awk -v
	
	

	
	awk -v atm1="P" '{
	if($13==atm1 && $13<$2) 
	printf(-1)
	else
	printf(0)
	}'
	
	
	awk '{
	if (NR%2) 
	printf("%s ", $0)
	else 
	printf("%s\n", $0)
	}' > icharge_fragments.txt
	


grep "ATOM" 2LDT_nlb_decoy_5.pdb  | awk -v atm1="C5'" -v atm2="O5'" '{if($2==1 || ($3==atm1 && $2>10) || 
	($3==atm2 && $2>10)) print $2}' | sed "\$a 1002" |
	awk '{
	if (NR%2) 
	printf("%s   -", $0)
	else 
	printf("%s\n", $0)
	}'

				1   -36   0 33
               37   -70   0 67
               71   -104   0  101
               105   -138   0  135
               139   -171   0  168
               172   -205   0  202
               206   -235   0  232
               236   -268   0  265
               269   -299   0  296
               300   -333   0  330
               334   -367   0  364
               368   -398   0  395
               399   -429   0  426
               430   -463   0  460
               464   -494   0  491
               495   -527   0  524
               528   -560   0  557
               561   -594   0  591
               595   -628   0  625
               629   -658   0  655
               659   -688   0  685
               689   -721   0  718
               722   -754   0  751
               755   -787   0  784
               788   -820   0  817
               821   -851   0  848
               852   -881   0  878
               882   -912   0  909
               913   -943   0  940
               944   -974   0   971
               975   -1002   0 
   