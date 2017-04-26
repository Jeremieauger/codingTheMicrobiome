#!/bin/bash

#PBS -N _concatSelecto
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=04:00:00

cd /mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto

function concatenate {
    # Getting the sample IDs and the directory
    sample_dir=$1
    sample=$(basename $sample_dir)
    # Removing the files, if they exists
    rm -f ${sample}_R1.fastq.gz
    rm -f ${sample}_R2.fastq.gz
    # Retrieving the file handles, sorting and concatenating
    array_R1=( $(find ${sample_dir} -name '*_R1_*' | sort) )
    printf '%s\ ' "${array_R1[@]}" | xargs -n 1 -P 1 -I {} bash -c "cat {} > ${sample}_R1.fastq.gz"
    array_R2=( $(find ${sample_dir} -name '*_R2_*' | sort) )
    printf '%s\ ' "${array_R2[@]}" | xargs -n 1 -P 1 -I {} bash -c "cat {} > ${sample}_R2.fastq.gz"
}
export -f concatenate


FASTQDIR=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/dubemar1_group/Reads-Selectomics

find $FASTQDIR -maxdepth 1 -type d -iname 'sample*' -print0 |
xargs -0 -n 1 -P 2 -I {} bash -c 'concatenate {}'

