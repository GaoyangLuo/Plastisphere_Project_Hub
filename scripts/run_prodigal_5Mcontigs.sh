#!/bin/bash
#SBATCH -p jufeng   
#SBATCH -q huge                       
#SBATCH -J geneS3                
#SBATCH -c 2

# source ~/miniconda3/bin/activate vs2
# mamba init
# mamba activate vs2
source ~/miniconda3/bin/activate prodigal

WORKDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/2_assembly/5M/S3
cd $WORKDIR

for i in *.fa
do
base=${i%%.fa*}
prodigal -i ${i} -d ${base}.fna -p meta -f gff -o ${base}_fna.gff
# prodigal -i ${base}.fna -a ${base}.faa -o ${base}.gff -f gff -p meta
done

for i in *.fa
do
base=${i%%.fa*}
prodigal -i ${base}.fna -a ${base}_fna2faa.faa -o ${base}_fna2faa.gff -f gff -p meta
done

# mv *faa ../fna2faa
# mv *fna ../fna2faa
# mv *gff ../fna2faa
