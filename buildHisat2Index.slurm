#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=50G
#SBATCH --job-name=hisat2index
#SBATCH --output=hisat.out
#SBATCH --error=hisat.error


cd $SLURM_SUBMIT_DIR

module use /projects/community/modulefiles
module load python/2.7.12
module load HISAT2/2.1.0


hisat2-build -p 2 /Homo_sapiens_assembly38.fa genome
