
cd /storage/jufengLab/luogaoyang/software/MetaBinner/scripts

for i in /storage/jufengLab/luogaoyang/metagenome_project/DSR/2_assembly/*fa
do

python gen_kmer.py ${i} 1000 4 

done
