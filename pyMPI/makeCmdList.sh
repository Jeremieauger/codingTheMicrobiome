#/bin/bash

pushd /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/metagenomicFastq

declare -A r1Param
declare -A r2Param
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
    r1Param+=( [${r1Name}]=${r1List[@]} )
    r2Param+=( [${r2Name}]=${r2List[@]} )
done

pushd /home/augerjer/PBS_WorkDir/pyMPI

#echo -e '#!/bin/bash\n\n#PBS -N _catAllTest\n#PBS -V\n#PBS -l walltime=00:05:00\n' > catAllFastq.sh
#echo '#/bin/bash' > catAllFastq.sh
truncate -s 0 catAllFastq.sh
for key in "${!r1Param[@]}"; do 
    echo "cat ${r1Param[$key]} > ./fastqCat/$key" >> catAllFastq.sh
done
for key in "${!r2Param[@]}"; do 
    echo "cat ${r2Param[$key]} > ./fastqCat/$key" >> catAllFastq.sh
done