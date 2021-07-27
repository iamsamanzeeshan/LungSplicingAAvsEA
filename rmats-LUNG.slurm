#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24
#SBATCH --time=168:00:00
#SBATCH --mem=120G
#SBATCH --job-name=rMATS-LUNG
#SBATCH --output=rmats2LUNG.out
#SBATCH --error=rmats2LUNG.error

cd $SLURM_SUBMIT_DIR

conda init
source ~/.bashrc
conda activate py2
module use /projects/community/modulefiles
module load STAR/2.5.2a
module load samtools/1.3.1

python2 /projects/community/miniconda3/envs/py2/rMATS/RNASeq-MATS.py -b1 /scratch/tumor.sorted.nodup.bam -b2 /scratch/normal.sorted.nodup.bam -gtf /home/GTF/gencode.v34.primary_assembly.annotation.gtf -o rMATS_Output_LUNG -t 'paired' -libType fr-unstranded -novelSS 1 -len 126 -keepTemp

conda deactivate 



