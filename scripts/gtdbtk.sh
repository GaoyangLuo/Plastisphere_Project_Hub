#!/bin/bash
#SBATCH -p jufeng   
#SBATCH -q huge                       
#SBATCH -J gtdbtk-wd                   
#SBATCH -c 32

WORKDIR=/storage/jufengLab/luogaoyang/metagenome_project/DSR/1_clean/wood_all_reads
BIN_DIR=$WORKDIR/BIN_REFINEMENT_1/metawrap_50_10_bins
OUT_DIR=$WORKDIR/GTDB_OUT
LOG_FILE=$OUT_DIR/gtdbtk_analysis.log

source ~/miniconda3/bin/activate /storage/jufengLab/zhangguoqing/Software/anaconda3/envs/gtdbtk-v2/

cd $WORKDIR

mkdir -p $OUT_DIR/tmp

# 记录开始时间
echo "GTDB-Tk 分析开始: $(date)" > $LOG_FILE

gtdbtk classify_wf --genome_dir $BIN_DIR \
            --out_dir $OUT_DIR \
            -x fa \
            --cpus 32 &>> $LOG_FILE

# 记录结束时间
echo "GTDB-Tk 分析结束: $(date)" >> $LOG_FILE

# 提示用户分析完成
echo "GTDB-Tk 分析完成！结果保存在: $OUT_DIR。日志文件: $LOG_FILE"