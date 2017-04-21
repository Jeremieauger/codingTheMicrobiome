import os, re

stoolSamples = re.findall(r'.*stool.*', open("List690-testedQc.txt", "r").read())

sampleNumbers = []
for sample in stoolSamples:
    sampleNumbers.append(sample.split('\"')[1])

# for sampleNumber in sampleNumbers:
#     cmd = "wget http://downloads.hmpdacc.org/data/HMASM/PGAs/stool/{0}.scaffolds.fa.bz2".format(sampleNumber)
#     os.system(cmd)

count = 0
for sampleNumber in sampleNumbers:
    if count > 10: 
        break
    count = count+1
    cmd = "wget http://downloads.hmpdacc.org/data/Illumina/stool/{0}.tar.bz2 -o input/{0}.tar.bz2".format(sampleNumber)
    os.system(cmd)


