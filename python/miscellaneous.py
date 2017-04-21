import os, re
from Bio import SeqIO

def convertGbk(fileHandle):
    print("starting with file: {0}".format(fileHandle))
    gbk_filename = str(fileHandle)
    fna_filename = "{0}_converted.fna".format(gbk_filename.split('.')[0])
    input_handle  = open(gbk_filename, "r")
#    output_handle = open("fasta/{0}".format(fna_filename), "w")
    
    for seq_record in SeqIO.parse(input_handle, "embl"):
        output_handle.write(">{0} {1}\n{2}\n".format(seq_record.id, seq_record.description, seq_record.seq))
    
    output_handle.close()
    input_handle.close()


### Main
gbkFile = re.compile('.*\.dat')
for fileHandle in os.listdir():
#     if gbkFile.match(fileHandle):
#         convertGbk(fileHandle)

gbk_filename = "wgs_cdyy01_env.dat"
fna_filename = "{0}_converted.fna".format(gbk_filename.split('.')[0])
input_handle  = open(gbk_filename, "r")
#    output_handle = open("fasta/{0}".format(fna_filename), "w")

for seq_record in SeqIO.parse(input_handle, "embl"):
    print(">{0} {1}".format(seq_record.id, seq_record.description))



from Bio import SeqIO
for index, record in enumerate(SeqIO.parse("wgs_cdyy01_env.dat", "embl")):
    print("index %i, ID = %s, length %i, with %i features"
          % (index, record.id, len(record.seq), len(record.features)))




fnaFile = re.compile('.*\.fna$')
for fileName in os.listdir():
    if fnaFile.match(fileName):
        for seq_record in SeqIO.parse(fileName, "fasta"):
            print("{0}01  = {1}".format(seq_record.id.split('01')[0], fileName.split('.')[0]))
            break

import os, re
from Bio import SeqIO
import subprocess

def system_call(command):
    p = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    return p.stdout.read()

cmd = 'find . -name "*.fna"'
fnaList = system_call(cmd)




fnaFile = re.compile('.*\.fna$')
for fileName in os.listdir():
    if fnaFile.match(fileName):
        for seq_record in SeqIO.parse(fileName, "fasta"):
            print("{0}01  = {1}".format(seq_record.id.split('01')[0], fileName.split('.')[0]))
            break

bob2 = ""
fnaFile = re.compile('.*\.fna$')
for fileName in os.listdir():
    if fnaFile.match(fileName):
        for seq_record in SeqIO.parse(fileName, "fasta"):
            bob1 = seq_record.id.split('01')[0] 
            if bob1 == bob2:
                pass
            else :
                bob2 = bob1
                print(fileName)





### script to verify 100%-0% of blast in "CECA01=GCA_001408275"
# 'CDZI01___GCA_001403195.txt', 'CECA01___GCA_001408275.txt', 'GCA_001408275___CECA01.txt', 'CDTY01___GCA_001409035.txt'
# Identities = 12580/12580 (100%), Gaps = 0/12580 (0%)

import os,re

counts = dict()
lineCounter = 0
alignStart = re.compile('^>')
identLine = re.compile(' Identities')
for line in open("CDTY01___GCA_001409035.txt", "r"):
    if alignStart.match(line):
        lineCounter = 0
    lineCounter += 1
    if lineCounter == 6:
        if identLine.match(line):
            infos = re.search('(\d+%).*(\d+%)', line)
            (identity, gap) = infos.group(1,2)
            tupleStr = "{0}-{1}".format(identity, gap)
            counts[tupleStr] = counts.get(tupleStr, 0) + 1
        else:
            print("...: {0}".format(line))














