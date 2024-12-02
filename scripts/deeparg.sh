#!/bin/bash
#SBATCH -p jufeng   
#SBATCH -q huge                       
#SBATCH -J deeparg-nb                 
#SBATCH -c 16

WORKDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/wood_all_reads/PREDICT_GENES

cd $WORKDIR

source ~/miniconda3/bin/activate /storage/jufengLab/zhangguoqing/Software/anaconda3/envs/deeparg

deeparg_db=/storage/jufengLab/zhangguoqing/Database/deeparg-data

for i in *faa
do
deeparg predict \
    --model LS \
    -i $i \
    -o ${i%%.faa*}_DeepARG.out \
    -d $deeparg_db \
    --type prot \
    --arg-alignment-overlap 0.7
done

mv *_DeepARG.out ../../4_annotation/deeparg_out/
