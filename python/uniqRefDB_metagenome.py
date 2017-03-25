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
SeqIO.write(records, "uniqAllGenomes.fasta", "fasta")


#=========================================================================================
### Notes 
#=========================================================================================
# 
# awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < allGenomes.fasta > tempAllGenomes.fa
#
# [augerjer@ip05-mp2 refGenomes]$ grep ">" allGenomes.fasta | wc -l
# 5175
# [augerjer@ip05-mp2 refGenomes]$ grep ">" allGenomes.fasta | sort | uniq | wc -l
# 5142
# 
# 
# 34 (the extra being 'NC_021231')
# 
# grep "^>" allGenomes.fasta | grep NC_021231
# >gi|529974880|ref|NC_021231.1| Klebsiella pneumoniae subsp. rhinoscleromatis strain SB3432, plasmid pKRH, complete genome
# >gi|529974880|ref|NC_021231.1| Klebsiella pneumoniae plasmid pKRH, complete sequence
# 
# grep ">" allGenomes.fasta | sort | uniq -c | egrep ^[ ]+2
# 
# The final file contains 5141 distinct sequences. 
#
#
# 2 >gi|10955262|ref|NC_002127.1| Escherichia coli O157:H7 str. Sakai plasmid pOSAK1, complete sequence
# 2 >gi|10955266|ref|NC_002128.1| Escherichia coli O157:H7 str. Sakai plasmid pO157, complete sequence
# 2 >gi|146351220|ref|NC_009453.1| Arthrobacter sp. Rue61a plasmid pAL1, complete sequence
# 2 >gi|15829254|ref|NC_002695.1| Escherichia coli O157:H7 str. Sakai chromosome, complete genome
# 2 >gi|349703191|ref|NC_016046.1| Oscillibacter valericigenes Sjm18-20 plasmid pOBV01, complete sequence
# 2 >gi|350268398|ref|NC_016048.1| Oscillibacter valericigenes Sjm18-20, complete genome
# 2 >gi|400752908|ref|NC_018286.1| Phaeobacter gallaeciensis 2.10 chromosome, complete genome
# 2 >gi|400759986|ref|NC_018421.1| Phaeobacter gallaeciensis 2.10 plasmid pPGA2_239, complete sequence
# 2 >gi|400760195|ref|NC_018422.1| Phaeobacter gallaeciensis 2.10 plasmid pPGA2_71, complete sequence
# 2 >gi|400760244|ref|NC_018423.1| Phaeobacter gallaeciensis 2.10 plasmid pPGA2_95, complete sequence
# 2 >gi|403525101|ref|NC_018531.1| Arthrobacter sp. Rue61a chromosome, complete genome
# 2 >gi|403529507|ref|NC_018532.1| Arthrobacter sp. Rue61a plasmid p232, complete sequence
# 2 >gi|404282430|ref|NC_018588.1| Listeria monocytogenes SLCC2372, complete genome
# 2 >gi|406591804|ref|NC_018625.1| Chlamydia psittaci CP3 chromosome, complete genome
# 2 >gi|406592921|ref|NC_018626.1| Chlamydia psittaci NJ1 chromosome, complete genome
# 2 >gi|406598883|ref|NC_018634.1| Chlamydia psittaci CP3 plasmid pcpCP3, complete sequence
# 2 >gi|406598909|ref|NC_018637.1| Chlamydia psittaci NJ1 plasmid pcpNJ1, complete sequence
# 2 >gi|409188586|ref|NC_018889.1| Listeria monocytogenes SLCC2372 plasmid pLM1-2cUG1, complete sequence
# 2 >gi|428314827|ref|NC_019730.1| Oscillatoria nigro-viridis PCC 7112 plasmid pOSC7112.02, complete sequence
# 2 >gi|428315019|ref|NC_019731.1| Oscillatoria nigro-viridis PCC 7112 plasmid pOSC7112.03, complete sequence
# 2 >gi|428315127|ref|NC_019764.1| Oscillatoria nigro-viridis PCC 7112 plasmid pOSC7112.04, complete sequence
# 2 >gi|428315182|ref|NC_019729.1| Oscillatoria nigro-viridis PCC 7112, complete genome
# 2 >gi|428320964|ref|NC_019732.1| Oscillatoria nigro-viridis PCC 7112 plasmid pOSC7112.05, complete sequence
# 2 >gi|428320975|ref|NC_019763.1| Oscillatoria nigro-viridis PCC 7112 plasmid pOSC7112.01, complete sequence
# 2 >gi|428768415|ref|NC_019776.1| Cyanobacterium aponinum PCC 10605 chromosome, complete genome
# 2 >gi|428771774|ref|NC_019777.1| Cyanobacterium aponinum PCC 10605 plasmid pCYAN10605.01, complete sequence
# 2 >gi|434384225|ref|NC_019697.1| Chamaesiphon minutus PCC 6605, complete genome
# 2 >gi|434389900|ref|NC_019698.1| Chamaesiphon minutus PCC 6605 plasmid pCHA6605.02, complete sequence
# 2 >gi|436736818|ref|NC_020053.1| Chamaesiphon minutus PCC 6605 plasmid pCHA6605.01, partial sequence
# 2 >gi|469816323|ref|NC_020539.1| Staphylococcus aureus subsp. aureus ST228 plasmid pI8T7 complete sequence, isolate 18583
# 2 >gi|470223734|ref|NC_020568.1| Staphylococcus aureus subsp. aureus ST228 complete genome, isolate 18583
# 2 >gi|529985600|ref|NC_021232.1| Klebsiella pneumoniae subsp. rhinoscleromatis strain SB3432, complete genome
# 2 >gi|568144401|ref|NC_023065.1| Magnetospirillum gryphiswaldense MSR-1 v2, complete genome
# VS
# FOUND a duplicate!: gi|404282430|ref|NC_018588.1|
# FOUND a duplicate!: gi|409188586|ref|NC_018889.1|
# FOUND a duplicate!: gi|406592921|ref|NC_018626.1|
# FOUND a duplicate!: gi|406598909|ref|NC_018637.1|
# FOUND a duplicate!: gi|529974880|ref|NC_021231.1|
# FOUND a duplicate!: gi|529985600|ref|NC_021232.1|
# FOUND a duplicate!: gi|146351220|ref|NC_009453.1|
# FOUND a duplicate!: gi|403525101|ref|NC_018531.1|
# FOUND a duplicate!: gi|403529507|ref|NC_018532.1|
# FOUND a duplicate!: gi|406591804|ref|NC_018625.1|
# FOUND a duplicate!: gi|406598883|ref|NC_018634.1|
# FOUND a duplicate!: gi|400752908|ref|NC_018286.1|
# FOUND a duplicate!: gi|400759986|ref|NC_018421.1|
# FOUND a duplicate!: gi|400760195|ref|NC_018422.1|
# FOUND a duplicate!: gi|400760244|ref|NC_018423.1|
# FOUND a duplicate!: gi|10955262|ref|NC_002127.1|
# FOUND a duplicate!: gi|10955266|ref|NC_002128.1|
# FOUND a duplicate!: gi|15829254|ref|NC_002695.1|
# FOUND a duplicate!: gi|568144401|ref|NC_023065.1|
# FOUND a duplicate!: gi|469816323|ref|NC_020539.1|
# FOUND a duplicate!: gi|470223734|ref|NC_020568.1|
# FOUND a duplicate!: gi|349703191|ref|NC_016046.1|
# FOUND a duplicate!: gi|350268398|ref|NC_016048.1|
# FOUND a duplicate!: gi|428768415|ref|NC_019776.1|
# FOUND a duplicate!: gi|428771774|ref|NC_019777.1|
# FOUND a duplicate!: gi|428315182|ref|NC_019729.1|
# FOUND a duplicate!: gi|428314827|ref|NC_019730.1|
# FOUND a duplicate!: gi|428315019|ref|NC_019731.1|
# FOUND a duplicate!: gi|428320964|ref|NC_019732.1|
# FOUND a duplicate!: gi|428320975|ref|NC_019763.1|
# FOUND a duplicate!: gi|428315127|ref|NC_019764.1|
# FOUND a duplicate!: gi|434384225|ref|NC_019697.1|
# FOUND a duplicate!: gi|434389900|ref|NC_019698.1|
# FOUND a duplicate!: gi|436736818|ref|NC_020053.1|

