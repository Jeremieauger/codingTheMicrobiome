#!/bin/bash

#PBS -N _concat
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=00:35:00

cd /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge

function concatenate {

    # Getting the sample IDs and the directory
    sample_dir=$1
    sample=$(basename $sample_dir)

    # Removing the files, if they exists
    rm -f ${sample}_R1.fastq.gz
    rm -f ${sample}_R2.fastq.gz

    for f_r1 in $sample_dir/*_R1_*.fastq.gz
    do
        # Getting the name of the R2 file
        f_r2=$(echo $f_r1 | sed -e 's/_R1_/_R2_/')

        # Concatenating the two FASTQ files
        cat $f_r1 >> ${sample}_R1.fastq.gz
        cat $f_r2 >> ${sample}_R2.fastq.gz
    done

}
export -f concatenate


FASTQDIR=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/metagenomicFastq


find $FASTQDIR -maxdepth 1 -type d -iname 'sample*' -print0 |
xargs -0 -n 1 -P 24 -I {} bash -c 'concatenate {}'
