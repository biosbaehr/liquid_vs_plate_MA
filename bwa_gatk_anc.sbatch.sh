#!/bin/bash
#SBATCH -n 2
#SBATCH -t 0-12:00
#SBATCH -A weichinh
#SBATCH -o trimm_bwa_gatk.anc.slurm.%j.out
#SBATCH -e trimm_bwa_gatk.anc.slurm.%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=weichinh@asu.edu


#module load picard/2.9.2
#picard CreateSequenceDictionary R=Ecoli.NC_000913.fa O=Ecoli.NC_000913.dict

module purge
#module load trimmomatic/0.33
module load bwa/0.7.17
module load gatk/4.2.5.0
module load samtools/1.15.1

#bwa index Ecoli.NC_000913.fa
#samtools faidx Ecoli.NC_000913.fa
#java -jar /packages/7x/trimmomatic/0.33/trimmomatic.jar PE -threads 16 D00L00-E150005155_L01_68_1.fq.gz D00L00-E150005155_L01_68_2.fq.gz D00L00-E150005155_L01_68_1.paired.clean.fq.gz D00L00-E150005155_L01_68_1.unpaired.clean.fq.gz D00L00-E150005155_L01_68_2.paired.clean.fq.gz D00L00-E150005155_L01_68_2.unpaired.clean.fq.gz ILLUMINACLIP:BGISEQ_DNBSEQ_MGISEQ_primer.fas:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

bwa mem -t 16 -K 10000000 -R '@RG\tID:D00L00-E150005155_L01\tLB:L01_68\tPL:BGISEQ\tSM:D00L00-E150005155_L01_68' NC_000913.fa D00L00-E150005155_L01_68_1.paired.clean.fq.gz D00L00-E150005155_L01_68_2.paired.clean.fq.gz > D00L00-E150005155_L01_68.sam

gatk SortSam --java-options -Xmx10g --MAX_RECORDS_IN_RAM 5000000 -I D00L00-E150005155_L01_68.sam -O D00L00-E150005155_L01_68.bam --SORT_ORDER coordinate

gatk MarkDuplicates --java-options -Xmx10g -I D00L00-E150005155_L01_68.bam -O D00L00-E150005155_L01_68.mark_dups.bam -M D00L00-E150005155_L01_68.metrics.txt

samtools index D00L00-E150005155_L01_68.mark_dups.bam

gatk HaplotypeCaller --java-options -Xmx10g -I D00L00-E150005155_L01_68.mark_dups.bam -O D00L00-E150005155_L01_68.mark_dups.vcf -R NC_000913.fa --native-pair-hmm-threads 16
