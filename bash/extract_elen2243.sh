#!/bin/bash

#PBS -N _extractReads
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=01:00:00
#PBS -q qtest

cd /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut
bamOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut

function extractReads {
    # Getting the sample IDs and the directory
    fileHandle=$(echo $1 | cut -d. -f1,2)
    sample=$(basename $fileHandle | cut -d_ -f1)
    bamOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut
    samtools view -f 2 -h -b ${fileHandle} "gi|257789778|ref|NC_013204.1|" > ${sample}_f2_elen2243.bam
}
export -f extractReads

find $bamOut -iname '*sorted.bam.bai' -print0 |
xargs -0 -n 1 -P 24 -I {} bash -c "extractReads {}"




#!/bin/bash

#PBS -N _extractReads
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=01:00:00
#PBS -q qtest

cd /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut
bamOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut

function extractReads {
    # Getting the sample IDs and the directory
    fileHandle=$(echo $1 | cut -d. -f1,2)
    sample=$(basename $fileHandle | cut -d_ -f1)
    bamOut=/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut
    bedtools bamtobed -i ${sample}_f2_elen2243.bam -cigar | awk -F '\t' '($3-$2 > 90) { print $4 }' > ${sample}_elen2243_HitsList.txt
}
export -f extractReads

find $bamOut -iname '*sorted.bam.bai' -print0 |
xargs -0 -n 1 -P 24 -I {} bash -c "extractReads {}"



# && bedtools bamtobed -i ${sample}_f2_elen2243.bam -cigar | awk -F '\t' '($3-$2 > 90) { print $4 }' > ${sample}_elen2243_HitsList.txt


# for inHandle in `ls | grep "\.bam\.bai"`
# do 
#     ID=`echo $inHandle | cut -d '_' -f 1,2`
#     samtools view -f 2 -h -b ${inHandle::-4} CP001726.1 > ${ID}_f2_meta_1726.bam
#     bedtools bamtobed -i ${ID}_f2_meta_1726.bam -cigar | awk -F '\t' '($3-$2 > 90) { print $4 }' > ${ID}_meta_f2_1726_HitsList.txt
# done

#


# >gi|257789778|ref|NC_013204.1| Eggerthella lenta DSM 2243 chromosome, complete genome
# >gi|339443684|ref|NC_015738.1| Eggerthella sp. YY7918, complete genome

samtools view -f 2 -h -b /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/bamOut/P22J90_sorted.bam.bai "gi|257789778|ref|NC_013204.1|"

