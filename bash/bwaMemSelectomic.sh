#!/bin/bash

#PBS -N _bwaMemSelecto
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=20:00:00
#PBS -q qwork

cd /mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto
mergeDir=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto

function bwaMem {
    # Getting the sample IDs and the directory
    f_r1=$1
    f_r2=$(echo $f_r1 | sed -e 's/_R1/_R2/')
    sample=$(basename $f_r1 | cut -d. -f1 | cut -d_ -f2)
    samOut=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto/samOut
    genomeHandle=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/metagenome/metagenome.fna
    #echo -e "bwa mem -t 12 ${genomeHandle} \n${f_r1} \n${f_r2}"
    if [[ ! -e ${samOut}/${sample}.sam ]]; then
        bwa mem -t 6 ${genomeHandle} ${f_r1} ${f_r2} > ${samOut}/${sample}.sam && echo "`date`_${sample}_bwaMem_END" >> samLogs/${sample}_baMem.log
    fi
}
export -f bwaMem

#echo "`date`_BwaBatch_BEGIN" > samLogs/beginBwa.log
find $mergeDir -iname '*R1*' -print0 |
xargs -0 -n 1 -P 4 -I {} bash -c "bwaMem {}"
#echo "`date`_BwaBatch_END" > samLogs/endBwa.log


 



