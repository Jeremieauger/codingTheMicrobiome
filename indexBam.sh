#!/bin/bash

#PBS -N _bamIndex
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=06:00:00
#PBS -q qwork

cd /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut
bamOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut

function indexBam {
    # Getting the sample IDs and the directory
    fileHandle=$1
    sample=$(basename $fileHandle | cut -d. -f1 | cut -d_ -f2)
    bamOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut
    samtools index ${fileHandle} && echo "`date` ${sample}_index_END" >> bamLogs/${sample}_index.log
}
export -f indexBam

#echo "`date`_BEGIN_Index" > bamLogs/BEGINindex.log
find $bamOut -iname '*sorted.bam' -print0 |
xargs -0 -n 1 -P 24 -I {} bash -c "indexBam {}"
#echo "`date`_END_Index" > bamLogs/ENDindex.log
