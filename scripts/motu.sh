#!/bin/bash
#SBATCH -p jufeng   
#SBATCH -q huge                       
#SBATCH -J motu                   
#SBATCH -c 32

source ~/miniconda3/bin/activate /storage/jufengLab/zhaoze/Software/anaconda3/envs/motus3

work_dir=/storage/jufengLab/luogaoyang/metagenome_project/DSR/motu_res

fq_dir=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean

for i in /storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/*_1.fastq
do
filepath=${i}
filename=$(basename "$filepath")
for_file=${i}
rev_file=${fq_dir}/${filename%%_1.fastq*}_2.fastq
motus profile -f ${for_file} -r ${rev_file} -t 32 -p -q > ${work_dir}/${filename%%_clean_1.fastq*}_taxonomy_profile.txt
done