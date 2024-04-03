module load bwa/0.7.17
module load samtools/1.15.1
module load gatk/4.2.5.0

#bwa index Escherichia_coli_str_k_12_substr_mg1655.fa
#samtools faidx Escherichia_coli_str_k_12_substr_mg1655.fa
#gatk CreateSequenceDictionary --java-options -Xmx10g -R Escherichia_coli_str_k_12_substr_mg1655.fa -O Escherichia_coli_str_k_12_substr_mg1655.fa.dict
#cp Escherichia_coli_str_k_12_substr_mg1655.fa.dict Escherichia_coli_str_k_12_substr_mg1655.dict

bwa index NC_000913.fa
samtools faidx NC_000913.fa
gatk CreateSequenceDictionary --java-options -Xmx10g -R NC_000913.fa -O NC_000913.fa.dict
cp NC_000913.fa.dict NC_000913.dict