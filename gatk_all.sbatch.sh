#!/bin/bash
#SBATCH -n 4
#SBATCH -t 2-00:00
#SBATCH -A weichinh
#SBATCH -o gatk.slurm.%j.out
#SBATCH -e gatk.slurm.%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=weichinh@asu.edu

module purge
module load gatk/4.2.5.0

#Need to Finish D00L00-E150005155_L01_68.mark_dups.vcf first

declare -a name1List=("D14L02" "D15L02" "D16L02" "D20L01" "D20L02" "D20L03" "D20L04" "D20L05" "D20L06" "D20L07" "D20L08" "D20L09" "D20L10" "D20L11" "D20L12" "D20L13" "D20L14" "D20L15" "D20L16" "D20P25" "D20P26" "D20P27" "D20P28" "D20P29" "D20P30" "D20P31" "D20P32" "D20P33" "D20P34" "D20P35" "D20P36" "D20P37" "D20P38" "D20P39" "D20P40")
declare -a name2List=("69" "70" "71" "121" "122" "123" "124" "125" "1" "2" "3" "4" "13" "14" "15" "16" "41" "42" "43" "44" "45" "46" "47" "48" "57" "58" "59" "60" "61" "62" "63" "64" "65" "66" "67")

for i in {0..34} #34
do
	name1="${name1List[$i]}"
	name2="${name2List[$i]}"
	completeName="${name1}-E150005155_L01_${name2}"

	echo "${completeName}"

	gatk SortSam --java-options -Xmx10g --MAX_RECORDS_IN_RAM 5000000 -I "${completeName}.sam" -O "${completeName}.bam" --SORT_ORDER coordinate

	gatk MarkDuplicates --java-options -Xmx10g -I "${completeName}.bam" -O "${completeName}.mark_dups.bam" -M "${completeName}.metrics.txt"

	gatk BaseRecalibrator --java-options -Xmx10g -I "${completeName}.mark_dups.bam" -O "${completeName}.BaseRecalibrator.txt" --known-sites D00L00-E150005155_L01_68.mark_dups.vcf -reference NC_000913.fa

	gatk ApplyBQSR --java-options -Xmx10g -R NC_000913.fa -I "${completeName}.mark_dups.bam" --bqsr-recal-file "${completeName}.BaseRecalibrator.txt" -O "${completeName}.nodups_BQSR.bam"

done