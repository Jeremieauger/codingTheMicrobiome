#!/bin/bash

#PBS -N _bwaMemLightII
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=6:00:00
#PBS -q qwork

cd /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/lightWeight
mergeDir=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/
# samOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/lightWeight/samOut
# genomeHandle=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/metagenome.fna

function bwaMem {
    # Getting the sample IDs and the directory
    f_r1=$1
    f_r2=$(echo $f_r1 | sed -e 's/_R1_/_R2_/')
    sample=$(basename $f_r1 | cut -d. -f1 | cut -d_ -f2)
    samOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/lightWeight/samOut
    genomeHandle=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/metagenome.fna
    if [[ ! -e ${samOut}/${sample}.sam ]]; then
        bwa mem -t 12 ${genomeHandle} ${f_r1} ${f_r2} > samOut/${sample}.sam && echo "`date`_${sample}_bwaMem_END" >> samLogs/${sample}_baMem.log
    fi
}
export -f bwaMem

echo "`date`_BwaBatch_BEGIN" > samLogs/beginBwa.log
find $mergeDir -iname '*R1*' -print0 |
xargs -0 -n 1 -P 2 -I {} bash -c "bwaMem {}"
echo "`date`_BwaBatch_END" > samLogs/endBwa.log


