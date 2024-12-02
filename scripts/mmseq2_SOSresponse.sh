#!/bin/bash
#SBATCH -p jufeng 
#SBATCH -q huge                       
#SBATCH -J ros_mm_wd        
#SBATCH -c 16

rec_mmseqdb=/storage/jufengLab/luogaoyang/db/ROS_related_genes/rec/mmseq2db/rec.mmseq2.db
gpx_mmseqdb=/storage/jufengLab/luogaoyang/db/ROS_related_genes/gpx/mmseq2db/gpx.mmseq2.db
lex_mmseqdb=/storage/jufengLab/luogaoyang/db/ROS_related_genes/lex/mmseq2db/lexA.mmseq2.db
sod_mmseqdb=/storage/jufengLab/luogaoyang/db/ROS_related_genes/sod/mmseq2db/sod.mmseq2.db
umu_mmseqdb=/storage/jufengLab/luogaoyang/db/ROS_related_genes/umu/mmseq2db/umu.mmseq2.db



WORKDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/3_gene_5M
OUTDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/4_annotation/ROS_gene_mmseq_contig_level_out/sustech_gene_out
cd $WORKDIR
mkdir -p $OUTDIR
source ~/miniconda3/bin/activate mmseq2

for i in *faa
do

base=${i%%.faa*}
#rec
mmseqs easy-search \
        ${i} \
        $rec_mmseqdb \
        $OUTDIR/${base}_rec.m8 \
        /storage/jufengLab/luogaoyang/tmp_mmseq \
        --min-seq-id 0.7 -c 0.8 --cov-mode 1 --threads 16

#gpx
mmseqs easy-search \
        ${i} \
        $gpx_mmseqdb \
        $OUTDIR/${base}_gpx.m8 \
        /storage/jufengLab/luogaoyang/tmp_mmseq \
        --min-seq-id 0.7 -c 0.8 --cov-mode 1 --threads 16

#lex
mmseqs easy-search \
        ${i} \
        $lex_mmseqdb \
        $OUTDIR/${base}_lex.m8 \
        /storage/jufengLab/luogaoyang/tmp_mmseq \
        --min-seq-id 0.7 -c 0.8 --cov-mode 1 --threads 16
#sod
mmseqs easy-search \
        ${i} \
        $sod_mmseqdb \
        $OUTDIR/${base}_sod.m8 \
        /storage/jufengLab/luogaoyang/tmp_mmseq \
        --min-seq-id 0.7 -c 0.8 --cov-mode 1 --threads 16
#umu
mmseqs easy-search \
        ${i} \
        $umu_mmseqdb \
        $OUTDIR/${base}_umu.m8 \
        /storage/jufengLab/luogaoyang/tmp_mmseq \
        --min-seq-id 0.7 -c 0.8 --cov-mode 1 --threads 16

done



