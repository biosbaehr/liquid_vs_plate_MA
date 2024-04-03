#!/bin/bash
#SBATCH -n 4
#SBATCH -t 2-00:00
#SBATCH -A weichinh
#SBATCH -o bwa_all.slurm.%j.out
#SBATCH -e bwa_all.slurm.%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=weichinh@asu.edu

module purge
module load bwa/0.7.17

declare -a name1List=("D14L02" "D15L02" "D16L02" "D20L01" "D20L02" "D20L03" "D20L04" "D20L05" "D20L06" "D20L07" "D20L08" "D20L09" "D20L10" "D20L11" "D20L12" "D20L13" "D20L14" "D20L15" "D20L16" "D20P25" "D20P26" "D20P27" "D20P28" "D20P29" "D20P30" "D20P31" "D20P32" "D20P33" "D20P34" "D20P35" "D20P36" "D20P37" "D20P38" "D20P39" "D20P40")
declare -a name2List=("69" "70" "71" "121" "122" "123" "124" "125" "1" "2" "3" "4" "13" "14" "15" "16" "41" "42" "43" "44" "45" "46" "47" "48" "57" "58" "59" "60" "61" "62" "63" "64" "65" "66" "67")

for i in {0..34} #34
do 
	name1="${name1List[$i]}"
	name2="${name2List[$i]}"
	completeName="${name1}-E150005155_L01_${name2}"

	echo "${completeName}"
	
	bwa mem -t 16 -K 10000000 -R "@RG\tID:${name1}-E150005155_L01\tLB:L01_${name2}\tPL:BGISEQ\tSM:${name1}-E150005155_L01_${name2}" "NC_000913.fa" "${completeName}_1.paired.clean.fq.gz" "${completeName}_2.paired.clean.fq.gz" > "${completeName}.sam"

done
