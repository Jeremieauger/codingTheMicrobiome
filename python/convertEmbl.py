import os, re
from Bio import SeqIO

def convertGbk(fileHandle):
    print("starting with file: {0}".format(fileHandle))
    gbk_filename = str(fileHandle)
    fna_filename = "{0}_converted.fna".format(gbk_filename.split('.')[0])
    input_handle  = open(gbk_filename, "r")
    output_handle = open("fasta/{0}".format(fna_filename), "w")
    
    for seq_record in SeqIO.parse(input_handle, "embl"):
        output_handle.write(">{0} {1}\n{2}\n".format(seq_record.id, seq_record.description, seq_record.seq))
    
    output_handle.close()
    input_handle.close()


### Main
gbkFile = re.compile('.*\.dat')
for fileHandle in os.listdir():
    if gbkFile.match(fileHandle):
        convertGbk(fileHandle)




