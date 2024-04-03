#!/bin/bash
#SBATCH -n 2
#SBATCH -t 1-00:00
#SBATCH -A weichinh
#SBATCH -o trimm_bwa_gatk.slurm.%j.out
#SBATCH -e trimm_bwa_gatk.slurm.%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=weichinh@asu.edu

module purge
module load trimmomatic/0.33
module load bwa/0.7.17
module load gatk/4.2.5.0
module load samtools/1.15.1

java -jar /packages/7x/trimmomatic/0.33/trimmomatic.jar PE -threads 16 D14L02-E150005155_L01_69_1.fq.gz D14L02-E150005155_L01_69_2.fq.gz D14L02-E150005155_L01_69_1.paired.clean.fq.gz D14L02-E150005155_L01_69_1.unpaired.clean.fq.gz D14L02-E150005155_L01_69_2.paired.clean.fq.gz D14L02-E150005155_L01_69_2.unpaired.clean.fq.gz ILLUMINACLIP:BGISEQ_DNBSEQ_MGISEQ_primer.fas:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

bwa mem -t 16 -K 10000000 -R '@RG\tID:D14L02-E150005155_L01\tLB:L01_69\tPL:BGISEQ\tSM:D14L02-E150005155_L01_69' Ecoli.NC_000913.3.fa D14L02-E150005155_L01_69_1.paired.clean.fq.gz D14L02-E150005155_L01_69_2.paired.clean.fq.gz > D14L02-E150005155_L01_69.sam

gatk SortSam --java-options -Xmx10g --MAX_RECORDS_IN_RAM 5000000 -I D14L02-E150005155_L01_69.sam -O D14L02-E150005155_L01_69.bam --SORT_ORDER coordinate

gatk MarkDuplicates --java-options -Xmx10g -I D14L02-E150005155_L01_69.bam -O D14L02-E150005155_L01_69.mark_dups.bam -M D14L02-E150005155_L01_69.metrics.txt

gatk BaseRecalibrator --java-options -Xmx10g -I D14L02-E150005155_L01_69.mark_dups.bam -O D14L02-E150005155_L01_69.BaseRecalibrator.txt --known-sites D00L00-E150005155_L01_68.mark_dups.vcf -reference Ecoli.NC_000913.3.fa

gatk ApplyBQSR --java-options -Xmx10g -R Ecoli.NC_000913.3.fa -I D14L02-E150005155_L01_69.mark_dups.bam --bqsr-recal-file D14L02-E150005155_L01_69.BaseRecalibrator.txt -O D14L02-E150005155_L01_69.nodups_BQSR.bam

samtools index D14L02-E150005155_L01_69.nodups.BQSR.bam

gatk HaplotypeCaller --java-options -Xmx10g -I D14L02-E150005155_L01_69.nodups_BQSR.bam -O D14L02-E150005155_L01_69.BQSR.vcf -R Ecoli.NC_000913.3.fa --native-pair-hmm-threads 16

samtools index D14L02-E150005155_L01_69.mark_dups.bam

gatk HaplotypeCaller --java-options -Xmx10g -I D14L02-E150005155_L01_69.mark_dups.bam -O D14L02-E150005155_L01_69.dups.vcf -R Ecoli.NC_000913.3.fa --native-pair-hmm-threads 16
