# RNAFMO
Tools for Applying FMO Calculations to RNA containing systems

## Generate Decoys Using KGSrna (Gollum)

### (1) Generate H-bond file
```
export RNAVIEW=/home/afrankz/local_software/repo/RNAVIEW/
export PATH=$PATH:${RNAVIEW}/bin/
rnaview coors/NMR/2KOC.pdb
````

### (2) Generate Decoys
```
mkdir -p output
export KGSRNA=/home/afrankz/local_software/repo/KGSrna/Linux64/KGSrna/KGSrna
${KGSRNA} --radius 5 --samples 100 --initial 2KOC.pdb_nmr.pdb --hbondMethod rnaview --hbondFile 2KOC.pdb_nmr.pdb.out 
````
