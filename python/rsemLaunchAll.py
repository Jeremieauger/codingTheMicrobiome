#!/usr/bin/env python
import os, re, glob

os.chdir('/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/NCBI-Taxonomy/rsemShellCmd')
cmd = 'rm /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/NCBI-Taxonomy/rsemShellCmd/*'
os.system(cmd)

r1List = glob.glob('/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/merge/*R1.fastq')
#r2List = [fh.replace('R1', 'R2') for fh in r1List]

for r1Handle in r1List:
    r2Handle = r1Handle.replace('R1', 'R2')
    samNum = r1Handle.split('/')[-1].split('_')[1]
    with open("{0}CalcExpr.sh".format(samNum), "a") as myfile:
        myfile.write("#!/bin/bash\n\n")
        myfile.write("#PBS -N _{0}exprLevel\n#PBS -V\n#PBS -S /bin/bash\n#PBS -l walltime=24:00:00\n".format(samNum))
        myfile.write("\nmodule load gcc/6.1.0\nmodule load bioinformatics/rsem/1.2.31\nmodule load bioinformatics/bowtie2\n\n")
        myfile.write("cd /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/NCBI-Taxonomy/rsemOut \n\n")
        myfile.write("rsem-calculate-expression -p 24 --paired-end \\\n                    --bowtie2 \\\n")
        myfile.write("                    {0} \\\n".format(r1Handle))
        myfile.write("                    {0} \\\n".format(r2Handle))
        myfile.write("                    /mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/NCBI-Taxonomy/rsemIndex/uniqGenomes.fasta \\\n")
        myfile.write("                    {0}_exprLevel \n\n".format(samNum))

