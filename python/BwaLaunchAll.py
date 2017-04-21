#!/usr/bin/env python
import os, re, glob

os.chdir('/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto/separateBwa')
cmd = 'rm /mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto/separateBwa/*'
os.system(cmd)

r1List = glob.glob('/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto/*R1.fastq')
#r2List = [fh.replace('R1', 'R2') for fh in r1List]

samOut = '/mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto/samOut'
genomeHandle = '/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/metagenome/metagenome.fna'

for r1Handle in r1List:
    r2Handle = r1Handle.replace('R1', 'R2')
    sample = r1Handle.split('/')[-1].split('_')[1]
    with open("{0}_makeBWA.sh".format(sample), "a") as myfile:
        myfile.write("#!/bin/bash\n\n")
        myfile.write("#PBS -N _{0}_makeBWA\n#PBS -V\n#PBS -S /bin/bash\n#PBS -l walltime=24:00:00\n".format(sample))
        myfile.write("\nmodule load bioinformatics/bwa\n\n")
        myfile.write("cd /mnt/parallel_scratch_mp2_wipe_on_december_2017/dubemar1/augerjer/mergeSelecto/samOut \n\n")
        myfile.write("bwa mem -t 24 {0} {1} {2} > {3}/{4}.sam\n".format(genomeHandle, r1Handle, r2Handle, samOut, sample))



# for fh in $(ls); do
#     qsub $fh
# done

