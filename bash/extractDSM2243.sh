#!/bin/bash

#PBS -N _extractDSM2243
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=20:00:00
#PBS -q qwork

module load bioinformatics/samtools/1.2

cd /mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/hmp/bamOut

function moreThan90 {
    fh=$1
    ID=$( basename $fh | cut -d_ -f1 )
    samtools view -f 2 -H ${fh} > ${ID}_f2_nc13204.sam
    samtools view ${fh} | awk 'match($3, /NC_013204.1/) {print $0}' >> ${ID}_f2_nc13204.sam
    samtools view -S -b ${ID}_f2_nc13204.sam > ${ID}_f2_nc13204.bam
    bedtools bamtobed -i ${ID}_f2_nc13204.bam -cigar | awk -F '\t' '($3-$2 > 90) { print $4 }' > ${ID}_f2_nc13204_HitsList.txt
}
export -f moreThan90

bamOut=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/hmp/bamOut

find $bamOut -iname '*sorted\.bam' -print0 | 
xargs -0 -n 1 -P 1 -I {} bash -c 'moreThan90 {}'


