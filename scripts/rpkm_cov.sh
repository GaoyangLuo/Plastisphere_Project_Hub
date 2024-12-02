#!/bin/bash
#SBATCH -p jufeng-gpu
#SBATCH -q huge                       
#SBATCH -J rkmud
#SBATCH -c 32


WORKDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean_sustech/5M/undo
cd $WORKDIR
source ~/miniconda3/bin/activate CompRanking_abundance_env

# #write a for circle to run all the files in the cov dir
# for i in *fna
# do
# base=${i/_5M_contigs.fna/}
# base2=${base/.contigs/}
# #run bowtie2
# bowtie2-build ${base}_5M_contigs.fna ${base}_5M_contigs.fna_bwt
# bowtie2 --very-sensitive \
#         --no-unal \
#         -x ${base}_5M_contigs.fna_bwt \
#         -1 ${base2}_clean_1.fq -2 ${base2}_clean_2.fq \
#         -S ${base}.sam \
#         -p 32

# #run samtools
# samtools view -bS ${base}.sam > ${base}.bam
# samtools sort ${base}.bam -o ${base}.sorted.bam

# #run bamm
# bamm filter -b ${base}.sorted.bam -o $WORKDIR --percentage_id 0.95 --percentage_aln 0.95

# #run bbmap
# pileup.sh in=${base}.sorted_filtered.bam out=${base}_5M_contigs_gene.cov rpkm=${base}_5M_contigs_gene.rpkm overwrite=true

# done

#write a for circle to run all the files in the cov dir
for i in *fa
do
base=${i/_5M_contigs.fa/}
base2=${base/.contigs/}
#run bowtie2
bowtie2-build ${base}_5M_contigs.fa ${base}_5M_contigs.fa_bwt
bowtie2 --very-sensitive \
        --no-unal \
        -x ${base}_5M_contigs.fa_bwt \
        -1 ${base2}_clean_1.fq -2 ${base2}_clean_2.fq \
        -S ${base}.sam \
        -p 32

#run samtools
samtools view -bS ${base}.sam > ${base}.bam
samtools sort ${base}.bam -o ${base}.sorted.bam

#run bamm
bamm filter -b ${base}.sorted.bam -o $WORKDIR --percentage_id 0.95 --percentage_aln 0.95

#run bbmap
pileup.sh in=${base}.sorted_filtered.bam out=${base}_5M_contigs.cov rpkm=${base}_5M_contigs.rpkm overwrite=true

done