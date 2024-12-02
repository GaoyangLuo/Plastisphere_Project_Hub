#!/bin/bash
#SBATCH -p jufeng  
#SBATCH -q huge                       
#SBATCH -J qtBin-nb        
#SBATCH -c 24
work_dir=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/nonbio_all_reads

cd $work_dir

source ~/miniconda3/bin/activate /storage/jufengLab/zhangguoqing/Software/anaconda3/envs/metawrap

metawrap quant_bins -b BIN_REFINEMENT_1/metawrap_50_10_bins -o QUANT_BINS -a ASSEMBLY/final_assembly.fasta S*fastq





