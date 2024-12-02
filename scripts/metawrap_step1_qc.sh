#!/bin/bash
#SBATCH -p jufeng   
#SBATCH -q huge                       
#SBATCH -J metawrap_qc                   
#SBATCH -c 64

cd /storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/tmp

source ~/miniconda3/bin/activate /storage/jufengLab/zhangguoqing/Software/anaconda3/envs/metawrap

for F in *_1.fastq; do 
	R=${F%_*}_2.fastq
	BASE=${F##*/}
	SAMPLE=${BASE%_*}
	metawrap read_qc -1 $F -2 $R -t 8 -o READ_QC/$SAMPLE &
done	

