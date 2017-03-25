#!/bin/bash

#PBS -N _makeBam
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=30:00:00
#PBS -q qwork

### Next time include these!!! SORT and INDEX, which are light!
### samtools sort ${file::-4}.bam -o ${file::-4}_sort.bam && samtools index ${file::-4}_sort.bam
### ou pas... vu comme ça bogue!

cd /mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto

function makeBam {
    # Getting the sample IDs and the directory
    fileHandle=$1
    sample=$(basename $fileHandle | cut -d. -f1 | cut -d_ -f2)
    bamOut=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto/bamOut
    echo ${fileHandle}
    samtools view -b -S -h ${fileHandle} > $bamOut/${sample}.bam
}
export -f makeBam

samOut=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto/samOut

find $samOut -iname '*sam' -print0 | 
xargs -0 -n 1 -P 24 -I {} bash -c 'makeBam {}'



