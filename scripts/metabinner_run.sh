#!/bin/bash
#SBATCH -p jufeng   
#SBATCH -q huge                       
#SBATCH -J b_gS3                   
#SBATCH -c 32

source ~/miniconda3/bin/activate metabinner_env
metabinner_path=/storage/jufengLab/luogaoyang/software/MetaBinner

cd ${metabinner_path}

# Step1 创建有名管道
[ -e ./fd1 ] || mkfifo ./fd1

# 创建文件描述符，以可读（<）可写（>）的方式关联管道文件，这时候文件描述符3就有了有名管道文件的所有特性 
exec 3<> ./fd1   

# 关联后的文件描述符拥有管道文件的所有特性,所以这时候管道文件可以删除，我们留下文件描述符来用就可以了
rm -rf ./fd1                    

# Step2 创建令牌 
for i in `seq 1 2`;
do
    # echo 每次输出一个换行符,也就是一个令牌
    echo >&3                   
done

#run multi-threads hmm
STARTTIME=$(date +%s)
echo "[TIMESTAMP] $(date) Running Metabinner..."	
#Running Seeker
for i in /storage/jufengLab/luogaoyang/metagenome_project/DSR/2_assembly/group_S3/*.contigs_1000.fa
do
filepath=${i}
filename=$(basename "$filepath")
filebase=${i%%.con*}

contig_file=${i}
coverage_profiles=/storage/jufengLab/luogaoyang/metagenome_project/DSR/metabinner/cov_metabinner/${filename%%.con*}/coverage_profile_f1000.tsv
kmer_profile=/storage/jufengLab/luogaoyang/metagenome_project/DSR/2_assembly/${filename%%.con*}.contigs_kmer_4_f1000.csv
out_dir=/storage/jufengLab/luogaoyang/metagenome_project/DSR/metabinner/output/${filename%%.con*}
# /storage/jufengLab/luogaoyang/metagenome_project/DSR/cov_metabinner/${filename%%.con*}

mkdir -p ${out_dir}

read -u3                    # read 命令每次读取一行，也就是拿到一个令牌 
{
  sleep 3
  echo "${i} 正在执行Metabinner binning"

  bash run_metabinner.sh \
    -a ${contig_file} \
    -o ${out_dir} \
    -d ${coverage_profiles} \
    -k ${kmer_profile} \
    -p ${metabinner_path} \
    -t 16

  echo >&3                # 执行完一条命令会将令牌放回管道
  
}&
done
wait

exec 3<&-                       # 关闭文件描述符的读
exec 3>&-                       # 关闭文件描述符的写

#finish Running Seeker
echo "[TIMESTAMP] $(date) Metabinner 运行... Done"
ENDTIME=$(date +%s)
echo "[TIMER] Running the Metabinner took $(($ENDTIME - $STARTTIME)) sec."