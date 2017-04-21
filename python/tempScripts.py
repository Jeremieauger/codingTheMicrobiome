import subprocess

def system_call(command):
    p = subprocess.Popen([command], stdout=subprocess.PIPE, shell=True)
    return p.stdout.read()



cmd = "cat 2016-10-06_GeneFindingMicrobiomeRaymondetal.pep | grep '^>Sample'"
allHeaders = system_call(cmd)
txtOut = allHeaders.decode("utf-8")
allHeadSplit = txtOut.split('\n')

# vérif # len(allHeadSplit) --> 10 216 458 --> ok!
# vérif # selon len(allHeadSplit), ce sont des tags uniques. 



--RÉÉCRIS EN PYTHON - OPENFILE (avec fichier en argument)

### Script qui parcours le fichier fasta et lit les entêtes
# exemple:  >Sample_P14J0-Assembly|contig-226000113_1 # 3 # 62 # -1 # ID=65206_1;partial=10;start_type=ATG;rbs_motif=GGAG/GAGG;rbs_spacer=5-10bp;gc_cont=0.333

import os, re, pandas as pd

headers = []
headRe = re.compile('^>Sample')
for line in open('2016-10-06_GeneFindingMicrobiomeRaymondetal.pep'):
    if headRe.match(line):
        tmp = line.split('#')[0]
        tmp2 = tmp.split('|')[1]
        headers.append(tmp2)


counts = dict()
for i in headers:
  counts[i] = counts.get(i, 0) + 1

countcount = 0
for x in counts:
    if 10 < counts[x] < 100:
        countcount += 1
        print(x, "\t", counts[x])
    
    print (x)
    for y in counts[x]:
        print (y,':',counts[x][y])

'''
Les numéros de contig (ex. contig-293000002_2 (count=13)) ne sont pas uniques - il y en a env. 3.3 millions
Aucun n'est là plus de 100 fois, mais plusieurs (164 464) etre 10 et 100 occurences (ex. 75 occurences, moy 33 pour ce range)
3 169 840 sont présents entre 1 et 10 fois (dont 2.5 millions 1 fois)
'''
# >Sampl_P[no échantillon]J[jour] | contig-nnnnnnn_[numéro du gène sur le contig]

wc -l 2016-10-06_GeneFindingMicrobiomeRaymondetal.pep
60 128 373


cat 2016-10-06_GeneFindingMicrobiomeRaymondetal.pep | grep '^>Sample' | wc -l
10 216 457   **** difficilement expliquable --> bon chiffre, autre chifres pas bons (pcq sortie de la fct en bytes au lieu de texte

cmd = "cat 2016-10-06_GeneFindingMicrobiomeRaymondetal.pep | grep '^>Sample'"
allHeaders = system_call(cmd)
len(allHeaders)
1 487 136 176
len(uniqueHeaders)
54


[augerjer@sripl-pgx-calc1 ulaval]$ cat 2016-10-06_GeneFindingMicrobiomeRaymondetal.pep  | grep '^>Sample_P10J0.*' | wc -l
168556
[augerjer@sripl-pgx-calc1 ulaval]$ cat 2016-10-06_GeneFindingMicrobiomeRaymondetal.pep  | grep '^>Sample.*' | wc -l
10216457
\>i.e 168 556 headersPourP10J0/ 10 216 457 de headersTotaux (ou ~1.6%)






makeblastdb -in mydb.fsa -parse_seqids -dbtype prot

### Blasted Elen_2528 and Elen_2529 against the local DB of assembled genes
# working on blast output # ex. # Sample_P18J7-Assembly|contig-19000062_14  # 12338 # 12670 # -1 # ...  35.0    1.4  

# python
import os, re

os.chdir('/shares/home/users/augerjer/ulaval/')

file = open('Output/elen2528')
hitRe = re.compile('^Sample')
lineCount = 0
IDs = []
idCounts = {}
times = []
timeCounts = {}
for line in file:
    if hitRe.match(line):
        lineCount +=1
        ID = line.split('_')[1].split('J')[0]
        IDs.append(ID)
        idCounts[ID] = idCounts.get(ID, 0) + 1
        time = "J{0}".format(line.split('J')[1].split('-')[0])
        times.append(time)
        timeCounts[time] = timeCounts.get(time, 0) + 1


for w in sorted(idCounts, key=idCounts.get, reverse=True):
  print (w, idCounts[w])

occurences = dict.fromkeys(range(1,50), 0)
for value in idCounts.values():
    occurences[value] += 1


'''
for Elen_2528
lineCount = 460
>>> print(timeCounts)
{'J7': 127, 'J0': 158, 'J90': 175}
>>> print(idCounts)
{'Sample_P8': 31, 'Sample_P9': 14, 'Sample_P5': 3, 'Sample_P6': 24, 'Sample_P7': 18, 'Sample_P1': 2, 'Sample_P2': 33, 'Sample_P3': 17, 'Sample_P38': 47, 'Sample_P17': 16, 'Sample_P14': 15, 'Sample_P15': 32, 'Sample_P12': 15, 'Sample_P13': 28, 'Sample_P10': 18, 'Sample_P11': 8, 'Sample_P18': 25, 'Sample_P19': 9, 'Sample_P25': 19, 'Sample_P23': 14, 'Sample_P22': 36, 'Sample_P21': 15, 'Sample_P20': 21}

J0=34,3%
J7=27,6%
J90=38%


for Elen_2529
lineCount = 500
>>> print(timeCounts)
{'J7': 119, 'J0': 171, 'J90': 210}
>>> print(idCounts)
{'Sample_P8': 41, 'Sample_P9': 5, 'Sample_P4': 2, 'Sample_P5': 1, 'Sample_P6': 36, 'Sample_P7': 20, 'Sample_P1': 3, 'Sample_P2': 27, 'Sample_P3': 18, 'Sample_P38': 46, 'Sample_P17': 10, 'Sample_P14': 11, 'Sample_P15': 48, 'Sample_P12': 11, 'Sample_P13': 27, 'Sample_P10': 14, 'Sample_P11': 6, 'Sample_P18': 32, 'Sample_P19': 7, 'Sample_P25': 42, 'Sample_P23': 11, 'Sample_P22': 46, 'Sample_P21': 17, 'Sample_P20': 19}

J0=34.2%
J7=23.8%
J90=42%

'''

#elen2528, elen2529, hybrid28-29, AEP95103, CZR72715, AMP34346
import os, re, pandas as pd, numpy as np
os.chdir('/shares/home/users/augerjer/ulaval/')

infoTable = pd.DataFrame(columns=('id','time','score','eValue'))
file = open('Output/elen2529')
hitRe = re.compile('^Sample')
for line in file:
    if hitRe.match(line):
        lastline = line
        infos = re.search('Sample_(P\d+)(J\d+)-Assembly.*\.\.\.\s+(.*).*\s\s\s(.*)\n', line)
        (id, time, score, eValue) = infos.group(1,2,3,4)
        infoTable.loc[len(infoTable)] = [id, time, float(score), float(eValue)]



# Snippet to generate de Graphs, Abundance v.s. patients 
uniqId = set(infoTable['id'])
deltaTable = []
for id in uniqId:
    tempDf = infoTable.loc[infoTable['id'] == id]
    J0 = len(tempDf.loc[tempDf['time'] == 'J0'])
    J7 = len(tempDf.loc[tempDf['time'] == 'J7'])
    J90 = len(tempDf.loc[tempDf['time'] == 'J90'])
    deltaTable.append([id, J0, J7, J90, J7-J0, J90-J0])

df = pd.DataFrame(deltaTable, columns=('id','J0','J7','J90', 'delta7', 'delta90'))

    
    
    
J0df = infoTable.loc[infoTable['time'] == 'J0']
J7df = infoTable.loc[infoTable['time'] == 'J7']
J90df = infoTable.loc[infoTable['time'] == 'J90']

str1 = " For Day0, the % of hits is {0:.1f}% ;    with avg. Score: {1:.1f} ;    and avg. eValue: {2:.3e} ;".format(len(J0df)/len(infoTable)*100, np.average(J0df['score']), np.average(J0df['eValue']))
str2 = "For Day7, the % of hits is {0:.1f}% ;    with avg. Score: {1:.1f} ;    and avg. eValue: {2:.3e} ;".format(len(J7df)/len(infoTable)*100, np.average(J7df['score']), np.average(J7df['eValue']))
str3 = "For Day90, the % of hits is {0:.1f}% ;    with avg. Score: {1:.1f} ;    and avg. eValue: {2:.3e} ;".format(len(J90df)/len(infoTable)*100, np.average(J90df['score']), np.average(J90df['eValue']))
print(str1,"\n",str2,"\n",str3)

#### Output for 2528
total = 460
 For Day0, the % of hits is 34.3% ;    with avg. Score: 41.8 ;    and  avg. eValue: 1.1027 ; 
 For Day7, the % of hits is 27.6% ;    with avg. Score: 40.7 ;    and  avg. eValue: 0.8869 ; 
 For Day90, the % of hits is 38.0% ;    with avg. Score: 41.0 ;    and  avg. eValue: 1.1695 ;

### Output for 2529
total = 500
 For Day0, the % of hits is 34.2% ;    with avg. Score: 102.3 ;    and  avg. eValue: 3.733e-17 ; 
 For Day7, the % of hits is 23.8% ;    with avg. Score: 101.0 ;    and  avg. eValue: 4.647e-17 ; 
 For Day90, the % of hits is 42.0% ;    with avg. Score: 101.8 ;    and  avg. eValue: 4.028e-17 ;

### Output for hybrid28-29
total = 500
 For Day0, the % of hits is 34.4% ;    with avg. Score: 103.2 ;    and  avg. eValue: 7.420e-17 ; 
 For Day7, the % of hits is 23.4% ;    with avg. Score: 101.7 ;    and  avg. eValue: 7.380e-17 ; 
 For Day90, the % of hits is 42.2% ;    with avg. Score: 102.2 ;    and  avg. eValue: 7.849e-17 ;

### Output for AMP34346 ### betalactamase (plasmid) [Escherichia coli]
total = 500
 For Day0, the % of hits is 29.8% ;    with avg. Score: 82.9 ;    and  avg. eValue: 7.618e-12 ; 
 For Day7, the % of hits is 33.4% ;    with avg. Score: 80.0 ;    and  avg. eValue: 9.628e-12 ; 
 For Day90, the % of hits is 36.8% ;    with avg. Score: 82.3 ;    and  avg. eValue: 7.524e-12 ;
 
### Output for AEP95103 ### TetB(P) ribosomal protection-like tetracycline resistance protein
total = 500
 For Day0, the % of hits is 34.0% ;    with avg. Score: 418.1 ;    and  avg. eValue: 1.388e-91 ; 
 For Day7, the % of hits is 31.4% ;    with avg. Score: 421.6 ;    and  avg. eValue: 5.166e-92 ; 
 For Day90, the % of hits is 34.6% ;    with avg. Score: 409.8 ;    and  avg. eValue: 1.607e-91 ;

### Output for CZR72715 ### teicoplanin resistance protein [Clostridium difficile]
total = 500
 For Day0, the % of hits is 36.0% ;    with avg. Score: 62.4 ;    and  avg. eValue: 1.304e-05 ; 
 For Day7, the % of hits is 25.8% ;    with avg. Score: 63.7 ;    and  avg. eValue: 1.006e-05 ; 
 For Day90, the % of hits is 38.2% ;    with avg. Score: 64.3 ;    and  avg. eValue: 1.117e-05 ;



# Voir si la variation s'explique par quelques patients, ou si elle est distribuée.




### Stript très lent, trop gros input pour python --> utiliser egrep
import os, re, pandas as pd
os.chdir('/shares/home/users/augerjer/ulaval/')

file = '2016-10-06_GeneFindingMicrobiomeRaymondetal.pep'
headerTable = pd.DataFrame(columns=('id','time'))
handle = open(file)
hitRe = re.compile('^>Sample')
for line in handle:
    if hitRe.match(line):
        infos = re.search('>Sample_(P\d+)(J\d+)-Assembly.*', line)
        (id, time) = infos.group(1,2)
        headerTable.loc[len(headerTable)] = [id, time]


# >Sample_P14J0-Assembly|contig-226000113_1 # 3 # 62 # -1 # ID=65206_1;partial=10;start_type=ATG;rbs_motif=GGAG/GAGG;rbs_spacer=5-10bp;gc_cont=0.333


import os, re, pandas as pd
os.chdir('/shares/home/users/augerjer/ulaval/')

file = '2016-10-06_GeneFindingMicrobiomeRaymondetal.pep'
headerTable = pd.DataFrame(columns=('id','time'))
handle = open(file)
hitRe = re.compile('^>Sample')
for line in handle:
    if hitRe.match(line):
        tmp = line.split('-As')[0].split('_')[1]
        id = tmp.split('J')[0]
        time = "J{0}".format(tmp.split('J')[1])
        headerTable.loc[len(headerTable)] = [id, time]



import os, re, pandas as pd
os.chdir('/shares/home/users/augerjer/ulaval/')

file = '2016-10-06_GeneFindingMicrobiomeRaymondetal.pep'
headerArray = []
handle = open(file)
hitRe = re.compile('^>Sample')
for line in handle:
    if hitRe.match(line):
        tmp = line.split('-As')[0].split('_')[1]
        id = tmp.split('J')[0]
        time = "J{0}".format(tmp.split('J')[1])
        headerArray.append([id, time])

df = pd.DataFrame(headerArray, columns=('id','time'))

j0df = df.loc[df['time'] == 'J0']
j7df = df.loc[df['time'] == 'J7']
j90df = df.loc[df['time'] == 'J90']






