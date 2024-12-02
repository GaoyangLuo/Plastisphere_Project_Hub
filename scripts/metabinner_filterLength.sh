
cd /storage/jufengLab/luogaoyang/software/MetaBinner/scripts

for i in /storage/jufengLab/luogaoyang/metagenome_project/DSR/2_assembly/*fa
do

python Filter_tooshort.py ${i} 1000

done
