#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
#SBATCH --mem=300G
#SBATCH --job-name=hisat2
#SBATCH --output=hisat2.out
#SBATCH --error=hisat2.error


cd $SLURM_SUBMIT_DIR


module use /projects/community/modulefiles
module load python/2.7.12
module load samtools/1.8-gc563
module load java/14.0.1
module load HISAT2/2.1.0

GENOME_Index="/projects/community/hisat2_index/Homo_sapiens/NCBI/grch38/Hisat2_Genome/genome"

Read1="tumor_R1_001.fastq.gz"
Read2="tumor_R2_001.fastq.gz"

hisat2 -p 8 -x "$GENOME_Index" -1 $Read1 -2 $Read2 -S tumor.sam --summary-file tumor.summary
samtools sort -@ 8 -o tumor.sorted.bam tumor.sam
java -XX:+UseParallelGC -XX:ParallelGCThreads=8 -Xms200g -Xmx200g -jar /projects/community/picard/build/libs/picard.jar MarkDuplicates INPUT=tumor.sorted.bam OUTPUT=tumor.sorted.nodup.bam METRICS_FILE=tumor.metric.txt REMOVE_DUPLICATES=true
samtools index tumor.sorted.nodup.bam
rm tumor.sam
rm tumor.sorted.bam
