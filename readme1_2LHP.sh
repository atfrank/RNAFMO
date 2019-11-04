COORS=/home/colltac/RNAFMO/2LHP_0/
frames=`seq 1 1 6`
for frame in $frames
do
    utility/./prepare_database.sh ${COORS}/2LHP_${frame}.pdb 2LHP_${frame} 100 charmm 1  tmp/    
done