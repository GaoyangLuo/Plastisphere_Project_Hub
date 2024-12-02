#!/bin/bash
#SBATCH -p jufeng-gpu  
#SBATCH -q huge                       
#SBATCH -J refinebin-we        
#SBATCH -c 32
work_dir=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/water_all_reads

cd $work_dir

source ~/miniconda3/bin/activate /storage/jufengLab/zhangguoqing/Software/anaconda3/envs/metawrap

mkdir -p $work_dir/BIN_REFINEMENT_1

# cat S*_1.fastq > ALL_READS_1.fastq
# cat S*_2.fastq > ALL_READS_2.fastq

metawrap bin_refinement -o BIN_REFINEMENT_1 -t 32 -A INITIAL_BINNING/metabat2_bins/ -B INITIAL_BINNING/maxbin2_bins/ -c 50 -x 10




