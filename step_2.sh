export RNAFMO=/home/hazwong/test/git_repository/RNAFMO
#export RNAFMO=/home/colltac/RNAFMO/
molecule="4A4U"
frames=`seq 1 1 6`
for frame in $frames
do
    ./rnafmo_input.sh ${molecule}_${frame}_charmm.pdb > ${molecule}_${frame}_fmo_input.inp
done
