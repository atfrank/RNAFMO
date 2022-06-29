# RNAFMO
Tools for Applying FMO Calculations to RNA containing systems

## Current Limitations
- Can't handle missing residues or non-standard PDB formatting
- Tested on Linux and Mac OS X

## Examples:

### RNA receptor
```
export RNAFMO=/path/RNAFMO/
${RNAFMO}/prep_fmo/rna.sh ${RNAFMO}/test/rna.pdb > ${RNAFMO}/test/rna_fmo.inp
```

### Ligand
```
export RNAFMO=/path/RNAFMO/
${RNAFMO}/prep_fmo/ligand.sh ${RNAFMO}/test/ligand.pdb -1 > ${RNAFMO}/test/ligand_fmo.inp
```

### RNA-ligand complex
```
export RNAFMO=/path/RNAFMO/
${RNAFMO}/prep_fmo/rna_ligand.sh ${RNAFMO}/test/rna.pdb ${RNAFMO}/test/ligand.pdb -1 > ${RNAFMO}/test/rna_ligand_fmo.inp
```
