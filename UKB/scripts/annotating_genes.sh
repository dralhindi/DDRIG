#!/bin/bash -l

module load bedtools2/2.29.2

##Get files
cp /share/hennlab/projects/UKB_Pigmentation/01-Working/d_workspace/glist-hg19 # file with gene names and ranges
cp -s /share/hennlab/projects/UKB_Pigmentation/01-Working/d_workspace/continuous-1717-both_sexes.metaonly.tsv # file I want to annotate 

##Make bed file of SNPs (tail to remove header, awk to format as chr, start, stop)
tail -n +2 continuous-1717-both_sexes.metaonly.tsv | awk '{print ($1"\t"$2"\t"$2) }' > Variants.bed

##Reformat glist file to be tab delimited
awk '{print ($1"\t"$2"\t"$3"\t"$4) }' glist-hg19 > glist-hg19.bed

##Output of format chr, snp position, geneID 
bedtools intersect -a Variants.bed -b glist-hg19.bed -wb | cut -f 1,2,7 > AnnotatedSNPs.txt




awk '{print ($1"\t"$2"\t"$3"\t"$4"\t"$5) }' glist-hg19 > glist-hg19.bed
