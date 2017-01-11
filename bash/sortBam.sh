#!/bin/bash

#PBS -N _sortBam
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=01:00:00
#PBS -q qtest

cd /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut

function sortBam {
    # Getting the sample IDs and the directory
    fileHandle=$1
    sample=$(basename $fileHandle | cut -d. -f1 | cut -d_ -f2)
    bamOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut
    samtools sort -@ 12 ${fileHandle} ${sample}_sorted #&& echo "`date`_${sample}_sort_END" >> bamLogs/${sample}.log
}
export -f sortBam

#echo "`date`_${sample}_sort_BEGIN_sortBam" > bamLogs/beginSort.log
find $bamOut -iname '*bam' -print0 | 
xargs -0 -n 1 -P 2 -I {} bash -c 'sortBam {}'
#echo "`date`_${sample}_sort_END_sortBam" > bamLogs/endSort.log


