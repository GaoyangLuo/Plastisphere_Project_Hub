#!/bin/bash
#SBATCH -p jufeng   
#SBATCH -q huge                       
#SBATCH -J gene-wd                  
#SBATCH -c 2

# source ~/miniconda3/bin/activate vs2
# mamba init
# mamba activate vs2
source ~/miniconda3/bin/activate prodigal

WORKDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/wood_all_reads/BIN_REFINEMENT_1/metawrap_50_10_bins
cd $WORKDIR

mkdir -p ../../PREDICT_GENES

for i in *fa
do
base=${i%%.fa*}
prodigal -i ${i} -o ${base}.gff -a ${base}.faa -d ${base}.fna -f gff -p meta
done

mv *faa ../../PREDICT_GENES
mv *fna ../../PREDICT_GENES
mv *gff ../../PREDICT_GENES
