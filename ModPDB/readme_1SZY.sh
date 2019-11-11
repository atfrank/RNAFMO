COORS= /home/colltac/RNAFMO/1SZY_0
frames=`seq 1 1 6`
for frame in $frames
do
    utility/./prepare_database.sh ${COORS}/1SZY_${frame}.pdb 1SZY_${frame} 100 charmm 1  tmp/    
done