#!/bin/bash

#PBS -N _bwaMemHmp
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=20:00:00
#PBS -q qwork

module load bioinformatics/bwa

cd /mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/hmp/testWget
fastqDir=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/hmp/testWget

function bwaMem {
    # Getting the sample IDs and the directory
    name=$(basename $1)
    f_r1=$(ls ${fastqDir}/${name}/*.1.fastq)
    f_r2=$(ls ${fastqDir}/${name}/*.2.fastq)
    samOut=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/hmp/samOut
    genomeHandle=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/metagenome/metagenome.fna
     if [[ ! -e ${samOut}/${name}.sam ]]; then
         bwa mem -t 12 ${genomeHandle} ${f_r1} ${f_r2} > ${samOut}/${name}.sam
     fi
}
export -f bwaMem

find $fastqDir -maxdepth 1 -type d -iname 'SRS*' -print0 |
xargs -0 -n 1 -P 2 -I {} bash -c "bwaMem {}"


