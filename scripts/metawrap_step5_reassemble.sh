#!/bin/bash
#SBATCH -p jufeng 
#SBATCH -q huge                       
#SBATCH -J rsb-wd        
#SBATCH -c 32
work_dir=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/wood_all_reads

cd $work_dir

source ~/miniconda3/bin/activate /storage/jufengLab/zhangguoqing/Software/anaconda3/envs/metawrap

metawrap reassemble_bins -o BIN_REASSEMBLY -1 ALL_READS_1.fastq -2 ALL_READS_2.fastq -t 32 -m 800 -c 50 -x 10 -b BIN_REFINEMENT_1/metawrap_50_10_bins





