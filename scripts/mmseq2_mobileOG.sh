#!/bin/bash
#SBATCH -p jufeng 
#SBATCH -q huge                       
#SBATCH -J mGO-wd        
#SBATCH -c 32

mobileOG_dioamonddb=/storage/jufengLab/luogaoyang/db/MobileOG-db/mmseq2db/mobileOG_1.6.mmseq2.db

WORKDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/wood_all_reads/PREDICT_GENES
OUTDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/4_annotation/wood_bin/mobileOG_out
cd $WORKDIR
mkdir -p $OUTDIR
source ~/miniconda3/bin/activate mmseq2

for i in *faa
do
base=${i%%.faa*}
#vfdb
mmseqs easy-search \
        ${i} \
        $mobileOG_dioamonddb \
        $OUTDIR/${base}_mobileOG_mmseq2.m8 \
        /storage/jufengLab/luogaoyang/tmp_mmseq \
        --min-seq-id 0.7 -c 0.8 --cov-mode 1 --threads 32
done



