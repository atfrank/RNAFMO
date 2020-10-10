# RNAFMO
Tools for Applying FMO Calculations to RNA containing systems

## Current Limitations
- Can't handle missing residues or non-standard PDB formatting

## Examples:

### RNA receptor
```
export RNAFMO=/path/RNAFMO/
${RNAFMO}/prep_fmo/ligand.sh ${RNAFMO}/test/rna.pdb
```

### Ligand
```
export RNAFMO=/path/RNAFMO/
${RNAFMO}/prep_fmo/ligand.sh ${RNAFMO}/test/ligand.pdb -1
```

### RNA-ligand complex
```
export RNAFMO=/path/RNAFMO/
${RNAFMO}/prep_fmo/rna_ligand.sh ${RNAFMO}/test/rna.pdb ${RNAFMO}/test/ligand.pdb -1
```