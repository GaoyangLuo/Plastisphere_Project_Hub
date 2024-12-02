#!/bin/bash
#SBATCH -p jufeng   
#SBATCH -q huge                       
#SBATCH -J iqt-b                   
#SBATCH -c 64
work_dir=//storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/bio_all_reads/GTDB_OUT/align/

cd $work_dir

conda activate /storage/jufengLab/zhangguoqing/Software/anaconda3/envs/iqtree

gtdbtk.bac120.user_msa.fasta.gz

