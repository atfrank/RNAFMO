COORS=/home/colltac/RNAFMO/1F5G_0/
frames=`seq 1 1 6`
for frame in $frames
do
    utility/./prepare_database.sh ${COORS}/1F5G_${frame}.pdb 1F5G_${frame} 100 charmm 1  tmp/    
done
