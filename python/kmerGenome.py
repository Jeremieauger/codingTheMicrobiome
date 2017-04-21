from Bio import SeqIO

def chunks(seq, win, step):
    seqlen = len(seq)
    for i in range(0,seqlen,step):
        j = seqlen if i+win>seqlen else i+win
        yield seq[i:j]
        if j==seqlen: break

outHandle = open("genomeToKmer/DSM2243.fna", "a")
for seq_record in SeqIO.parse("elen_DSM2243_genome.fna", "fasta"):
    seq = seq_record.seq
    kmerCount=1
    for subseq in chunks(seq, 20, 1):
        outHandle.write(">k-{0} ; E.Lenta-DSM2243\n{1}\n".format(kmerCount, subseq))
        kmerCount+=1



import os, re
from Bio import SeqIO
import subprocess

def system_call(command):
    p = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    return p.stdout.read()

def strip_non_didgit(string):
    ''' Returns the string with only number characters'''
    stripped = (c for c in string if 48 <= ord(c) <= 57)
    return ''.join(stripped)

try:
    os.remove("blastKmerOut.txt")
except OSError:
    pass

outHandle = open("blastKmerOut.txt", "a")
for seq_record in SeqIO.parse("DSM2243_toKmers.fna", "fasta"):
    seq = seq_record.seq
    position = seq_record.id[2:]
    cmd = "echo \"{0}\" | blastn -db refGenomeDB/allGenomes.fna -word_size 7 -outfmt 6 | wc -l".format(seq)
    nbOFHits = str(system_call(cmd))
    outHandle.write("{0},{1}\n".format(position, strip_non_didgit(nbOFHits)))







fig, ax = plt.subplots()
plt.title('Start position of K-mer')
ax.patch.set_facecolor('#e6e6e6')

xValues = np.array(temp[x])
yValues = np.array(temp[y])

# Making the horizontal lines
thresRed = 1000
thresYellow = 200
ax.axhline(y=thresRed, linestyle='-', linewidth=3, color='#ff0000', alpha=.5)
ax.axhline(y=thresYellow, linestyle='-', linewidth=5, color='#ffff00', alpha=.5)



plt.show()

fileName = "test.png"
plt.savefig(fileName)
plt.close()
























