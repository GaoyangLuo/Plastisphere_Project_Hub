#!/bin/bash
#SBATCH -p jufeng 
#SBATCH -q huge                       
#SBATCH -J sosall        
#SBATCH -c 64

all_ros_sos_mmseqdb=/storage/jufengLab/luogaoyang/db/SOS_ROS_gene_full/mmseq2db/all_ros_sos_genes.mmseq2.db

WORKDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/3_gene_5M
OUTDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/4_annotation/ROS_gene_mmseq_contig_level_out/sustech_gene_out
cd $WORKDIR
mkdir -p $OUTDIR
source ~/miniconda3/bin/activate mmseq2

for i in *faa
do

base=${i%%.faa*}
#all sos
mmseqs easy-search \
        ${i} \
        $all_ros_sos_mmseqdb \
        $OUTDIR/${base}_all_sos.m8 \
        /storage/jufengLab/luogaoyang/tmp_mmseq \
        --min-seq-id 0.6 -c 0.8 --cov-mode 1 --threads 64
done



