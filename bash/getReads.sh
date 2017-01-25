#!/bin/bash

#PBS -N _getReads
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=06:00:00

cd /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut
bamOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut

function getReads {
    hitsList=$1
    sample=$(echo $(basename $hitsList) | cut -d_ -f1)
    while read -r line
    do
        readID=`echo $line | cut -d '.' -f 2 | cut -d '/' -f 1`
        forward_reverse=`echo $line | cut -d '/' -f 2`
        #echo "grep -A 1 -m 1 ^@${readID} ../Sample_${sample}_R${forward_reverse}.fastq | tr \"@\" \">\" >> getReads/${sample}_MappedReads.fna"
        grep -A 1 -m 1 "^@${readID}" "../Sample_${sample}_R${forward_reverse}.fastq" | tr "@" ">" >> getReads/${sample}_MappedReads.fna
    done < "$hitsList"
}
export -f getReads

find $bamOut -iname '*hitsList*' -print0 |
xargs -0 -n 1 -P 24 -I {} bash -c 'getReads {}'