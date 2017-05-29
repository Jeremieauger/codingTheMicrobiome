#!/bin/bash

#PBS -N _bwaMemSelecto
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -q qwork

cd /mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/selectomic

function bwaMem {
    # Getting the sample IDs and the directory
    f_r1=$1
    f_r2=$(echo $f_r1 | sed -e 's/_R1/_R2/')
    sample=$(basename $f_r1 | cut -d. -f1 | cut -d_ -f2)
    samOut=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/selectomic/samOut
    #genomeHandle=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/metagenome/metagenome.fna
    genomeHandle=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/NCBI-Taxonomy/uniqGenomes/uniqGenomes.fasta
    if [[ ! -e ${samOut}/${sample}.sam ]]; then
        bwa mem -t 6 ${genomeHandle} ${f_r1} ${f_r2} > ${samOut}/${sample}.sam
    fi
}
export -f bwaMem

mergeDir=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/selectomic

find $mergeDir -iname '*R1*' -print0 |
xargs -0 -n 1 -P 4 -I {} bash -c "bwaMem {}"

