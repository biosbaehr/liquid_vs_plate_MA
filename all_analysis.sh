sh making_library.sh

sbatch trimm_all.sbatch.sh
sbatch bwa_gatk_anc.sbatch.sh
sbatch bwa_all.sbatch.sh
sbatch gatk_2_all.sbatch.sh
sbatch gatk_all.sbatch.sh
sbatch snpEff_all.sbatch.sh

mkdir out_BQSR_vcf
cp ./*.BQSR.vcf ./out_BQSR_vcf/
mkdir out_ann_vcf
cp ./*.BQSR.ann.vcf ./out_ann_vcf/

perl all_mut.pl

R CMD BATCH snm_pos_parallel_count.R
R CMD BATCH all_mut_snm_removed_rep.R
R CMD BATCH snm_count_by_line.R
R CMD BATCH snm_count_mut_type.R
R CMD BATCH snm_count_spec.R

R CMD BATCH indel_pos_parallel_count.R
R CMD BATCH all_mut_snm_removed_rep.R
R CMD BATCH indel_count_by_line.R
R CMD BATCH indel_count_mut_type.R

rm ./*.Rout