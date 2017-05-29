#!/bin/bash

#PBS -N _validateSamII
#PBS -V
#PBS -S /bin/bash
#PBS -l walltime=06:00:00
#PBS -q qwork


cd /mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/hmp/samOutII
samOutII=/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/hmp/samOutII

find $samOutII -name '*sam' -print0 | xargs -0 -I {} -n 1 -P 10 bash -c "bamUtil validate --in {} > {}_Validate.txt"

