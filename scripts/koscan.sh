#!/bin/bash
#SBATCH -p jufeng-gpu   
#SBATCH -q huge                       
#SBATCH -J koscan                   
#SBATCH -c 32

cd /storage/jufengLab/luogaoyang/software/kofam_scan
source ~/miniconda3/bin/activate hmmer
faa_dir=/storage/jufengLab/luogaoyang/metagenome_project/DSR/3_gene_5M

for i in $faa_dir/*faa
do
basename=$(basename "$i")
base=${basename%%.contig*}
./exec_annotation -o /storage/jufengLab/luogaoyang/metagenome_project/DSR/4_annotation/KO_scan_out/${base}.contigs_5M_contigs_fna2faa_koScan_out.txt \
                  --tmp-dir /storage/jufengLab/luogaoyang/metagenome_project/DSR/4_annotation/KO_scan_out/tmp_dir/${base} \
                   ${i}
done
        # -p config.yml \
        # --reannotation \