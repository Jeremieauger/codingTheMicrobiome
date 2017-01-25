import os
from Bio import SeqIO

allGenomes="/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/NCBI-Taxonomy/refGenomes/allGenomes.fasta"
destination="/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/NCBI-Taxonomy/refGenomes/uniqGenome"

os.chdir('/mnt/parallel_scratch_mp2_wipe_on_august_2017/dubemar1/augerjer/MicrobiomeData/NCBI-Taxonomy/refGenomes/')


record_dict=dict()

for record in SeqIO.parse("allGenomes.fasta", "fasta"):
#    print(len(record), record.id)
    if record.id in record_dict:
        print("FOUND a duplicate!: {}".format(record.id))
    else:
        record_dict[record.id] = record

records = record_dict.values()
SeqIO.write(records, "uniqAllGenomes.faa", "fasta")

