molecule="1SZY"
COORS=/home/hazwong/test/git_repository/RNAFMO/${molecule}_0
#COORS=/home/colltac/RNAFMO/${molecule}_0/
frames=`seq 1 1 6`
for frame in $frames
do
    utility/./prepare_database.sh ${COORS}/${molecule}_${frame}.pdb ${molecule}_${frame} 100 charmm 1  tmp/    
done
