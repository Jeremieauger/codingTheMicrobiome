#!/bin/bash

#PBS -N _catAllFastq
#PBS -V
#PBS -l walltime=00:05:00

r1Cmd=()
r2Cmd=()
for dirHandle in $(find -type d -name "Sample*")
do
r1List=()
r2List=()
    for fileHandle in $(find $dirHandle -name "*R1*fastq.gz"); do
        r1List+=($fileHandle)
    done
    for fileHandle in $(find $dirHandle -name "*R2*fastq.gz"); do
        r2List+=($fileHandle)
    done
    r1Name=`echo ${r1List[1]} | cut -d/ -f 3 | sed -r 's/_[[:digit:]]+/_ALL/'`
    r2Name=`echo ${r2List[1]} | cut -d/ -f 3 | sed -r 's/_[[:digit:]]+/_ALL/'`
    if [[ ! $r1Name =~ ^P ]]; then
        sampleID=`echo $dirHandle | cut -d_ -f 2`
        r1Suffix=`echo $r1Name |  cut -d_ -f 2,3,4`
        r2Suffix=`echo $r2Name |  cut -d_ -f 2,3,4`
        r1Name="${sampleID}_${r1Suffix}"
        r2Name="${sampleID}_${r2Suffix}"
    fi
    r1Cmd+=" cat ${r1List[@]} > ./fastqCat/${r1Name} "
    r2Cmd+=" cat ${r2List[@]} > ./fastqCat/${r2Name} "
done

echo ${r1Cmd[@]} | xargs -n 1 -P 12 -I {} bash -c '{}' bash
echo ${r2Cmd[@]} | xargs -n 1 -P 12 -I {} bash -c '{}' bash
