#!/bin/bash
#SBATCH -p jufeng   
#SBATCH -q huge                       
#SBATCH -J a2r-wd                   
#SBATCH -c 64
work_dir=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/wood_all_reads

cd $work_dir

source ~/miniconda3/bin/activate /storage/jufengLab/zhangguoqing/Software/anaconda3/envs/metawrap

mkdir -p $work_dir/ASSEMBLY
mkdir -p $work_dir/INITIAL_BINNING
mkdir -p $work_dir/BIN_REFINEMENT

# cat S*_1.fastq > ALL_READS_1.fastq
# cat S*_2.fastq > ALL_READS_2.fastq

metawrap assembly -1 ALL_READS_1.fastq -2 ALL_READS_2.fastq -m 200 -t 64 --megahit -o ASSEMBLY

metawrap binning -o INITIAL_BINNING -t 64 -a ASSEMBLY/final_assembly.fasta --metabat2 --maxbin2 --concoct S*fastq

metawrap bin_refinement -o BIN_REFINEMENT -t 64 -A INITIAL_BINNING/metabat2_bins/ -B INITIAL_BINNING/maxbin2_bins/ -C INITIAL_BINNING/concoct_bins/ -c 50 -x 10




