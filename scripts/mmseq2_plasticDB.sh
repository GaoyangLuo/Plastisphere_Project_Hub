#!/bin/bash
#SBATCH -p jufeng 
#SBATCH -q huge                       
#SBATCH -J plsdb-wd   
#SBATCH -c 32


plsdb_mmseqdb=/storage/jufengLab/luogaoyang/db/plasticDB/mmseq2db/plasticDB.mmseq2.db

WORKDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/wood_all_reads/PREDICT_GENES
OUTDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/4_annotation/wood_bin/plasticDB_mmseq_out
cd $WORKDIR
mkdir -p $OUTDIR
source ~/miniconda3/bin/activate mmseq2


for i in *faa
do
base=${i%%.faa*}
#vfdb
mmseqs easy-search \
        ${i} \
        $plsdb_mmseqdb \
        $OUTDIR/${base}_plsdb.m8 \
        /storage/jufengLab/luogaoyang/tmp_mmseq \
        --min-seq-id 0.5 -c 0.8 --cov-mode 1 --threads 32
done


