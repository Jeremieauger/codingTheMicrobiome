### bash script to compare the WGS files and the Assemblies files
toCompare="CDTY01=GCA_001409035 CDZS01=GCA_001409075 CDZO01=GCA_001282745 CEAK01=GCA_001282825 CDYY01=GCA_001282845 CDYU01=GCA_001282865 CEAX01=GCA_001403015 CEBY01=GCA_001403035 CEBV01=GCA_001403055 CECF01=GCA_001403075 CDZD01=GCA_001403115 CDZR01=GCA_001403135 CECB01=GCA_001403155 CDYF01=GCA_001403175 CDZI01=GCA_001403195 CDZX01=GCA_001403215 CDZQ01=GCA_001403235 CDYK01=GCA_001403255 CDZV01=GCA_001403275 CEAD01=GCA_001403295 CDYX01=GCA_001403315 CDZA01=GCA_001403335 CEAG01=GCA_001403355 CDTW01=GCA_001403375 CDYN01=GCA_001403395 CDYZ01=GCA_001403415 CDYG01=GCA_001403435 CDZP01=GCA_001403455 CEAE01=GCA_001403475 CDZB01=GCA_001403495 CEAJ01=GCA_001403515 CDYM01=GCA_001403535 CEAN01=GCA_001403555 CDZE01=GCA_001408255 CECA01=GCA_001408275 CEAZ01=GCA_001408295 CDZC01=GCA_001408315 CDZJ01=GCA_001408355 CDZK01=GCA_001408375 CEAC01=GCA_001408395 CEAM01=GCA_001408415 CEAF01=GCA_001408435 CDZU01=GCA_001408455 CDYQ01=GCA_001408475 CEAR01=GCA_001408495 CDYP01=GCA_001408535 CDYS01=GCA_001408555 CDYJ01=GCA_001408575 CDZW01=GCA_001408595 CEAL01=GCA_001408615 CDZT01=GCA_001408635 CDYT01=GCA_001408655 CEAA01=GCA_001408675 CDYH01=GCA_001408695 CEAH01=GCA_001408715 CDZL01=GCA_001408735 CDZF01=GCA_001408755 CDZM01=GCA_001408775 CEAQ01=GCA_001408795 CECJ01=GCA_001408815 CEAO01=GCA_001408835 CEAI01=GCA_001408855 CEAB01=GCA_001408875 CDYE01=GCA_001408895 CDZY01=GCA_001408915 CDYR01=GCA_001408955 CDZN01=GCA_001408975 CDYI01=GCA_001408995 CDZH01=GCA_001409015 CDZG01=GCA_001409055 CDYL01=GCA_001409095 CEAP01=GCA_001409115             SAMEA3182107= wgs_cdyy01_env.dat SAMEA3182058= wgs_cdyz01_env.dat SAMEA3182082= wgs_cdza01_env.dat SAMEA3182106= wgs_cdzb01_env.dat SAMEA3182085= wgs_cdzc01_env.dat SAMEA3182069= wgs_cdzd01_env.dat SAMEA3182109= wgs_cdze01_env.dat SAMEA3182086= wgs_cdzg01_env.dat SAMEA3182062= wgs_cdzh01_env.dat SAMEA3182110= wgs_cdzi01_env.dat SAMEA3182111= wgs_cdzj01_env.dat SAMEA3182108= wgs_cdzk01_env.dat SAMEA3182063= wgs_cdzl01_env.dat SAMEA3182087= wgs_cdzm01_env.dat SAMEA3182089= wgs_cdzn01_env.dat SAMEA3182064= wgs_cdzp01_env.dat SAMEA3182088= wgs_cdzo01_env.dat SAMEA3182112= wgs_cdzq01_env.dat SAMEA3182065= wgs_cdzr01_env.dat SAMEA3182113= wgs_cdzs01_env.dat SAMEA3182066= wgs_cdzt01_env.dat SAMEA3182114= wgs_cdzu01_env.dat SAMEA3182090= wgs_cdzv01_env.dat SAMEA3182067= wgs_cdzw01_env.dat SAMEA3182077= wgs_cdzx01_env.dat SAMEA3182091= wgs_cdzy01_env.dat SAMEA3182115= wgs_ceaa01_env.dat SAMEA3182046= wgs_ceab01_env.dat SAMEA3182094= wgs_ceac01_env.dat SAMEA3182053= wgs_cead01_env.dat SAMEA3182076= wgs_ceae01_env.dat SAMEA3182068= wgs_ceaf01_env.dat SAMEA3182116= wgs_ceag01_env.dat SAMEA3182092= wgs_ceah01_env.dat SAMEA3182100= wgs_ceai01_env.dat SAMEA3182047= wgs_ceaj01_env.dat SAMEA3182071= wgs_ceak01_env.dat SAMEA3182095= wgs_ceal01_env.dat SAMEA3182048= wgs_ceam01_env.dat SAMEA3182096= wgs_cean01_env.dat SAMEA3182049= wgs_ceao01_env.dat SAMEA3182097= wgs_ceaq01_env.dat SAMEA3182075= wgs_cear01_env.dat SAMEA3182073= wgs_ceap01_env.dat SAMEA3182098= wgs_ceax01_env.dat SAMEA3182074= wgs_ceaz01_env.dat SAMEA3182070= wgs_cebv01_env.dat SAMEA3182050= wgs_ceby01_env.dat SAMEA3182051= wgs_ceca01_env.dat SAMEA3182072= wgs_cecb01_env.dat SAMEA3182099= wgs_cecf01_env.dat SAMEA3182052= wgs_cecj01_env.dat SAMEA3182045= wgs_cdtw01_env.dat SAMEA3182101= wgs_cdty01_env.dat SAMEA3182078= wgs_cdyf01_env.dat SAMEA3182080= wgs_cdye01_env.dat SAMEA3182055= wgs_cdyg01_env.dat SAMEA3182056= wgs_cdyh01_env.dat SAMEA3182054= wgs_cdyi01_env.dat SAMEA3182079= wgs_cdyj01_env.dat SAMEA3182102= wgs_cdyk01_env.dat SAMEA3182104= wgs_cdyl01_env.dat SAMEA3182081= wgs_cdym01_env.dat SAMEA3182083= wgs_cdyn01_env.dat SAMEA3182084= wgs_cdyp01_env.dat SAMEA3182059= wgs_cdyq01_env.dat SAMEA3182103= wgs_cdyr01_env.dat SAMEA3182057= wgs_cdys01_env.dat SAMEA3182060= wgs_cdyt01_env.dat SAMEA3182105= wgs_cdyu01_env.dat SAMEA3182061= wgs_cdyx01_env.dat SAMEA3182093= wgs_cdzf01_env.dat"

inStr="CEBY01=GCA_001403035"
queryStr=`echo $inStr | cut -d '=' -f 1`
dbStr=`echo $inStr | cut -d '=' -f 2`
blastn -query `find . -iname "*${queryStr}*fna"` -db `find ./assembFiles/blastdb -iname "${dbStr}*fna"` -num_descriptions 1 -num_alignments 1 > "testOut_${queryStr}___${dbStr}.txt" & echo "processing ${queryStr}___${dbStr}.txt" 
# -outfmt 6 


### parsing this line
# Identities = 12580/12580 (100%), Gaps = 0/12580 (0%)

egrep  "^ Identities" CDZI01___GCA_001403195.txt | cut -d '(' -f 2 | cut -d ')' -f 1 | sort | uniq -c 


blastn -query ./wgsFiles/fasta/wgs_cdty01_env_converted.fna -db ./assembFiles/blastdb/GCA_001409035.1_P9E90-k21-2014-09-20_genomic.fna -max_target_seqs 1 > compareCDTY01___GCA_001409035.txt

-num_descriptions and -num_alignments

blastn -query ./wgsFiles/fasta/wgs_cdty01_env_converted.fna -db ./assembFiles/blastdb/GCA_001409035.1_P9E90-k21-2014-09-20_genomic.fna -num_descriptions 1 -num_alignments 1 > compareCDTY01___GCA_001409035.txt


CDZI01___GCA_001403195

blastn -query `find . -iname "*CDZI01*fna"` -db `find ./assembFiles/blastdb -iname "GCA_001403195*fna"` -num_descriptions 1 -num_alignments 1 > CDZI01___GCA_001403195.txt


blastp -query Elen_2528.fa -outfmt 6 -db 2016-10-06_GeneFindingMicrobiomeRaymondetal.pep -max_target_seqs 1 -out testOutputFrmt.txt &

-outfmt 6 -max_target_seqs 1 -out testOutputFrmt.txt &
-num_alignments 1 
blastp -query `find . -iname "*${queryStr}*fna"` -db `find ./assembFiles/blastdb -iname "${dbStr}*fna"` -outfmt 6 -max_target_seqs 1 -out testOutputFrmt.txt &



### Line to get the ftp adresses for FASTQ download

egrep "^PR" PRJEB8094.txt | cut -d$'\t' -f 10 | tr ';' '\n' | xargs -I {} -n 1 -P 3 wget -q -N  {}

egrep "^PR" PRJEB8094.txt | egrep "SAMEA3182071|SAMEA3182047|SAMEA3182095" | cut -d$'\t' -f 10 | tr ';' '\n' | xargs -I {} -n 1 -P 3 wget -q -c  {}

find -name "*gz" | xargs -P 3 gunzip &



### Script to map the fastq reads to reference using bwa
runNumbers=`ls | grep "ERR" | cut -d '_' -f 1 | sort | uniq`
genomeHandle="/shares/home/users/augerjer/PRJEB8094/elen_DSM2243/elen_DSM2243_genome.fna"
for num in ${runNumbers[@]}
do
    num_1=`ls | grep "$num"_1.fastq`
    num_2=`ls | grep "$num"_2.fastq`
    if [ ! -e samOut/${num}.sam ]
    then
        qsub -pe multiprocess 5 -N _bwa ~/bin/dummy.sh bash -c "bwa mem -t 5 ${genomeHandle} ${num_1} ${num_2} > samOut/${num}.sam"
    fi
done

### Script to map the fastq reads to reference using bwa
sampleNum=`ls | grep "ERR" | cut -d '_' -f 1 | sort | uniq`
genomeHandle="/shares/home/users/augerjer/PRJEB8094/elen_DSM2243/elen_DSM2243_genome.fna"
for num in ${runNumbers[@]}
do
    num_1=`ls | grep "$num"_1.fastq`
    num_2=`ls | grep "$num"_2.fastq`
    if [ ! -e samOut/${num}.sam ]
    then
        qsub -pe multiprocess 5 -N _bwa ~/bin/dummy.sh bash -c "bwa mem -t 5 ${genomeHandle} ${num_1} ${num_2} > samOut/${num}.sam"
    fi
done



### Script to join the Run Specific numbers by accession numbers and patients
accessions=( SAMEA3182071 SAMEA3182047 SAMEA3182095 )
for accession in ${accessions[@]} 
do
    temp=()
    temp+=(`egrep "^PR" PRJEB8094.txt | grep "$accession" | cut -d$'\t' -f 5`)
    echo ${accession}
    for line in ${temp[@]} 
    do
        echo "$line" | tr '\n' ';'
    done
    echo $'\n'
done



equis=( P10E0=CDYI01=SAMEA3182054=GCA_001408995 P10E7=CDYF01=SAMEA3182078=GCA_001403175 P10E90=CDYK01=SAMEA3182102=GCA_001403255 P11E0=CDYG01=SAMEA3182055=GCA_001403435 P11E7=CDYJ01=SAMEA3182079=GCA_001408575 P11E90=CDYR01=SAMEA3182103=GCA_001408955 P12E0=CDYH01=SAMEA3182056=GCA_001408695 P12E7=CDYE01=SAMEA3182080=GCA_001408895 P12E90=CDYL01=SAMEA3182104=GCA_001409095 P13E0=CDYS01=SAMEA3182057=GCA_001408555 P13E7=CDYM01=SAMEA3182081=GCA_001403535 P13E90=CDYU01=SAMEA3182105=GCA_001282865 P14E0=CDYZ01=SAMEA3182058=GCA_001403415 P14E7=CDZA01=SAMEA3182082=GCA_001403335 P14E90=CDZB01=SAMEA3182106=GCA_001403495 P15E0=CDYQ01=SAMEA3182059=GCA_001408475 P15E7=CDYN01=SAMEA3182083=GCA_001403395 P15E90=CDYY01=SAMEA3182107=GCA_001282845 P17E0=CDYT01=SAMEA3182060=GCA_001408655 P17E7=CDYP01=SAMEA3182084=GCA_001408535 P17E90=CDZK01=SAMEA3182108=GCA_001408375 P18E0=CDYX01=SAMEA3182061=GCA_001403315 P18E7=CDZC01=SAMEA3182085=GCA_001408315 P18E90=CDZE01=SAMEA3182109=GCA_001408255 P19E0=CDZH01=SAMEA3182062=GCA_001409015 P19E7=CDZG01=SAMEA3182086=GCA_001409055 P19E90=CDZI01=SAMEA3182110=GCA_001403195 P1E0=CDTW01=SAMEA3182045=GCA_001403375 P1E7=CDZD01=SAMEA3182069=GCA_001403115 P1E90=CDZF01=SAMEA3182093=GCA_001408755 P20E0=CDZL01=SAMEA3182063=GCA_001408735 P20E7=CDZM01=SAMEA3182087=GCA_001408775 P20E90=CDZJ01=SAMEA3182111=GCA_001408355 P21E0=CDZP01=SAMEA3182064=GCA_001403455 P21E7=CDZO01=SAMEA3182088=GCA_001282745 P21E90=CDZQ01=SAMEA3182112=GCA_001403235 P22E0=CDZR01=SAMEA3182065=GCA_001403135 P22E7=CDZN01=SAMEA3182089=GCA_001408975 P22E90=CDZS01=SAMEA3182113=GCA_001409075 P23C0=CDZT01=SAMEA3182066=GCA_001408635 P23C7=CDZV01=SAMEA3182090=GCA_001403275 P23C90=CDZU01=SAMEA3182114=GCA_001408455 P25C0=CDZW01=SAMEA3182067=GCA_001408595 P25C7=CDZY01=SAMEA3182091=GCA_001408915 P25C90=CEAA01=SAMEA3182115=GCA_001408675 P2E0=CEAB01=SAMEA3182046=GCA_001408875 P2E7=CEBV01=SAMEA3182070=GCA_001403055 P2E90=CEAC01=SAMEA3182094=GCA_001408395 P38C0=CEAF01=SAMEA3182068=GCA_001408435 P38C7=CEAH01=SAMEA3182092=GCA_001408715 P38C90=CEAG01=SAMEA3182116=GCA_001403355 P3E0=CEAJ01=SAMEA3182047=GCA_001403515 P3E7=CEAK01=SAMEA3182071=GCA_001282825 P3E90=CEAL01=SAMEA3182095=GCA_001408615 P4E0=CEAM01=SAMEA3182048=GCA_001408415 P4E7=CECB01=SAMEA3182072=GCA_001403155 P4E90=CEAN01=SAMEA3182096=GCA_001403555 P5E0=CEAO01=SAMEA3182049=GCA_001408835 P5E7=CEAP01=SAMEA3182073=GCA_001409115 P5E90=CEAQ01=SAMEA3182097=GCA_001408795 P6C0=CEBY01=SAMEA3182050=GCA_001403035 P6C7=CEAZ01=SAMEA3182074=GCA_001408295 P6C90=CEAX01=SAMEA3182098=GCA_001403015 P7C0=CECA01=SAMEA3182051=GCA_001408275 P7C7=CEAR01=SAMEA3182075=GCA_001408495 P7C90=CECF01=SAMEA3182099=GCA_001403075 P8C0=CECJ01=SAMEA3182052=GCA_001408815 P8C7=CEAE01=SAMEA3182076=GCA_001403475 P8C90=CEAI01=SAMEA3182100=GCA_001408855 P9E0=CEAD01=SAMEA3182053=GCA_001403295 P9E7=CDZX01=SAMEA3182077=GCA_001403215 P9E90=CDTY01=SAMEA3182101=GCA_001409035 )
for equi in ${equis[@]}
do
    patientID=`echo $equi | cut -d '=' -f 1`
    samID=`echo $equi | cut -d '=' -f 3`
    runIDs=`egrep "^PR" PRJEB8094.txt | grep ${samID} | cut -d$'\t' -f 5`
    for runID in ${runIDs[@]}
    do
        if [ -e ${runID}_1.fastq ]
        then 
            patientID=`echo $patientID | sed 's/\([EC]\)/_\1/'
            qsub -N _catFastq ~/bin/dummy.sh bash -c "cat ${runID}_1.fastq >> mergedFastq/${patientID}_1.fastq"
            qsub -N _catFastq ~/bin/dummy.sh bash -c "cat ${runID}_2.fastq >> mergedFastq/${patientID}_2.fastq"
        fi
    done
done


equis=( P10E0=CDYI01=SAMEA3182054=GCA_001408995 P10E7=CDYF01=SAMEA3182078=GCA_001403175 P10E90=CDYK01=SAMEA3182102=GCA_001403255 P11E0=CDYG01=SAMEA3182055=GCA_001403435 P11E7=CDYJ01=SAMEA3182079=GCA_001408575 P11E90=CDYR01=SAMEA3182103=GCA_001408955 P12E0=CDYH01=SAMEA3182056=GCA_001408695 P12E7=CDYE01=SAMEA3182080=GCA_001408895 P12E90=CDYL01=SAMEA3182104=GCA_001409095 P13E0=CDYS01=SAMEA3182057=GCA_001408555 P13E7=CDYM01=SAMEA3182081=GCA_001403535 P13E90=CDYU01=SAMEA3182105=GCA_001282865 P14E0=CDYZ01=SAMEA3182058=GCA_001403415 P14E7=CDZA01=SAMEA3182082=GCA_001403335 P14E90=CDZB01=SAMEA3182106=GCA_001403495 P15E0=CDYQ01=SAMEA3182059=GCA_001408475 P15E7=CDYN01=SAMEA3182083=GCA_001403395 P15E90=CDYY01=SAMEA3182107=GCA_001282845 P17E0=CDYT01=SAMEA3182060=GCA_001408655 P17E7=CDYP01=SAMEA3182084=GCA_001408535 P17E90=CDZK01=SAMEA3182108=GCA_001408375 P18E0=CDYX01=SAMEA3182061=GCA_001403315 P18E7=CDZC01=SAMEA3182085=GCA_001408315 P18E90=CDZE01=SAMEA3182109=GCA_001408255 P19E0=CDZH01=SAMEA3182062=GCA_001409015 P19E7=CDZG01=SAMEA3182086=GCA_001409055 P19E90=CDZI01=SAMEA3182110=GCA_001403195 P1E0=CDTW01=SAMEA3182045=GCA_001403375 P1E7=CDZD01=SAMEA3182069=GCA_001403115 P1E90=CDZF01=SAMEA3182093=GCA_001408755 P20E0=CDZL01=SAMEA3182063=GCA_001408735 P20E7=CDZM01=SAMEA3182087=GCA_001408775 P20E90=CDZJ01=SAMEA3182111=GCA_001408355 P21E0=CDZP01=SAMEA3182064=GCA_001403455 P21E7=CDZO01=SAMEA3182088=GCA_001282745 P21E90=CDZQ01=SAMEA3182112=GCA_001403235 P22E0=CDZR01=SAMEA3182065=GCA_001403135 P22E7=CDZN01=SAMEA3182089=GCA_001408975 P22E90=CDZS01=SAMEA3182113=GCA_001409075 P23C0=CDZT01=SAMEA3182066=GCA_001408635 P23C7=CDZV01=SAMEA3182090=GCA_001403275 P23C90=CDZU01=SAMEA3182114=GCA_001408455 P25C0=CDZW01=SAMEA3182067=GCA_001408595 P25C7=CDZY01=SAMEA3182091=GCA_001408915 P25C90=CEAA01=SAMEA3182115=GCA_001408675 P2E0=CEAB01=SAMEA3182046=GCA_001408875 P2E7=CEBV01=SAMEA3182070=GCA_001403055 P2E90=CEAC01=SAMEA3182094=GCA_001408395 P38C0=CEAF01=SAMEA3182068=GCA_001408435 P38C7=CEAH01=SAMEA3182092=GCA_001408715 P38C90=CEAG01=SAMEA3182116=GCA_001403355 P3E0=CEAJ01=SAMEA3182047=GCA_001403515 P3E7=CEAK01=SAMEA3182071=GCA_001282825 P3E90=CEAL01=SAMEA3182095=GCA_001408615 P4E0=CEAM01=SAMEA3182048=GCA_001408415 P4E7=CECB01=SAMEA3182072=GCA_001403155 P4E90=CEAN01=SAMEA3182096=GCA_001403555 P5E0=CEAO01=SAMEA3182049=GCA_001408835 P5E7=CEAP01=SAMEA3182073=GCA_001409115 P5E90=CEAQ01=SAMEA3182097=GCA_001408795 P6C0=CEBY01=SAMEA3182050=GCA_001403035 P6C7=CEAZ01=SAMEA3182074=GCA_001408295 P6C90=CEAX01=SAMEA3182098=GCA_001403015 P7C0=CECA01=SAMEA3182051=GCA_001408275 P7C7=CEAR01=SAMEA3182075=GCA_001408495 P7C90=CECF01=SAMEA3182099=GCA_001403075 P8C0=CECJ01=SAMEA3182052=GCA_001408815 P8C7=CEAE01=SAMEA3182076=GCA_001403475 P8C90=CEAI01=SAMEA3182100=GCA_001408855 P9E0=CEAD01=SAMEA3182053=GCA_001403295 P9E7=CDZX01=SAMEA3182077=GCA_001403215 P9E90=CDTY01=SAMEA3182101=GCA_001409035 )
for equi in ${equis[@]}
do
    patientsArray_1=()
    patientsArray_2=()
    patientID=`echo $equi | cut -d '=' -f 1 | sed 's/\([EC]\)/_\1/'`
    if [[ ! $patientID =~ P3_E90.* ]]
    then 
        continue
    fi
    echo $patientID
    sampleID=`echo $equi | cut -d '=' -f 3`
    runIDs=`egrep "^PR" PRJEB8094.txt | grep ${sampleID} | cut -d$'\t' -f 5`
    for runID in ${runIDs[@]}
    do
        patientsArray_1+=("${runID}_1.fastq")
        patientsArray_2+=("${runID}_2.fastq")
    done
#    echo ${patientsArray_1[@]}
    qsub -N _fastaMerge ~/bin/dummy.sh bash -c "cat ${patientsArray_1[@]} > mergedII/${patientID}_1.fastq"
    qsub -N _fastaMerge ~/bin/dummy.sh bash -c "cat ${patientsArray_2[@]} > mergedII/${patientID}_2.fastq"
done


### Autre version
equis=( P10E0=CDYI01=SAMEA3182054=GCA_001408995 P10E7=CDYF01=SAMEA3182078=GCA_001403175 P10E90=CDYK01=SAMEA3182102=GCA_001403255 P11E0=CDYG01=SAMEA3182055=GCA_001403435 P11E7=CDYJ01=SAMEA3182079=GCA_001408575 P11E90=CDYR01=SAMEA3182103=GCA_001408955 P12E0=CDYH01=SAMEA3182056=GCA_001408695 P12E7=CDYE01=SAMEA3182080=GCA_001408895 P12E90=CDYL01=SAMEA3182104=GCA_001409095 P13E0=CDYS01=SAMEA3182057=GCA_001408555 P13E7=CDYM01=SAMEA3182081=GCA_001403535 P13E90=CDYU01=SAMEA3182105=GCA_001282865 P14E0=CDYZ01=SAMEA3182058=GCA_001403415 P14E7=CDZA01=SAMEA3182082=GCA_001403335 P14E90=CDZB01=SAMEA3182106=GCA_001403495 P15E0=CDYQ01=SAMEA3182059=GCA_001408475 P15E7=CDYN01=SAMEA3182083=GCA_001403395 P15E90=CDYY01=SAMEA3182107=GCA_001282845 P17E0=CDYT01=SAMEA3182060=GCA_001408655 P17E7=CDYP01=SAMEA3182084=GCA_001408535 P17E90=CDZK01=SAMEA3182108=GCA_001408375 P18E0=CDYX01=SAMEA3182061=GCA_001403315 P18E7=CDZC01=SAMEA3182085=GCA_001408315 P18E90=CDZE01=SAMEA3182109=GCA_001408255 P19E0=CDZH01=SAMEA3182062=GCA_001409015 P19E7=CDZG01=SAMEA3182086=GCA_001409055 P19E90=CDZI01=SAMEA3182110=GCA_001403195 P1E0=CDTW01=SAMEA3182045=GCA_001403375 P1E7=CDZD01=SAMEA3182069=GCA_001403115 P1E90=CDZF01=SAMEA3182093=GCA_001408755 P20E0=CDZL01=SAMEA3182063=GCA_001408735 P20E7=CDZM01=SAMEA3182087=GCA_001408775 P20E90=CDZJ01=SAMEA3182111=GCA_001408355 P21E0=CDZP01=SAMEA3182064=GCA_001403455 P21E7=CDZO01=SAMEA3182088=GCA_001282745 P21E90=CDZQ01=SAMEA3182112=GCA_001403235 P22E0=CDZR01=SAMEA3182065=GCA_001403135 P22E7=CDZN01=SAMEA3182089=GCA_001408975 P22E90=CDZS01=SAMEA3182113=GCA_001409075 P23C0=CDZT01=SAMEA3182066=GCA_001408635 P23C7=CDZV01=SAMEA3182090=GCA_001403275 P23C90=CDZU01=SAMEA3182114=GCA_001408455 P25C0=CDZW01=SAMEA3182067=GCA_001408595 P25C7=CDZY01=SAMEA3182091=GCA_001408915 P25C90=CEAA01=SAMEA3182115=GCA_001408675 P2E0=CEAB01=SAMEA3182046=GCA_001408875 P2E7=CEBV01=SAMEA3182070=GCA_001403055 P2E90=CEAC01=SAMEA3182094=GCA_001408395 P38C0=CEAF01=SAMEA3182068=GCA_001408435 P38C7=CEAH01=SAMEA3182092=GCA_001408715 P38C90=CEAG01=SAMEA3182116=GCA_001403355 P3E0=CEAJ01=SAMEA3182047=GCA_001403515 P3E7=CEAK01=SAMEA3182071=GCA_001282825 P3E90=CEAL01=SAMEA3182095=GCA_001408615 P4E0=CEAM01=SAMEA3182048=GCA_001408415 P4E7=CECB01=SAMEA3182072=GCA_001403155 P4E90=CEAN01=SAMEA3182096=GCA_001403555 P5E0=CEAO01=SAMEA3182049=GCA_001408835 P5E7=CEAP01=SAMEA3182073=GCA_001409115 P5E90=CEAQ01=SAMEA3182097=GCA_001408795 P6C0=CEBY01=SAMEA3182050=GCA_001403035 P6C7=CEAZ01=SAMEA3182074=GCA_001408295 P6C90=CEAX01=SAMEA3182098=GCA_001403015 P7C0=CECA01=SAMEA3182051=GCA_001408275 P7C7=CEAR01=SAMEA3182075=GCA_001408495 P7C90=CECF01=SAMEA3182099=GCA_001403075 P8C0=CECJ01=SAMEA3182052=GCA_001408815 P8C7=CEAE01=SAMEA3182076=GCA_001403475 P8C90=CEAI01=SAMEA3182100=GCA_001408855 P9E0=CEAD01=SAMEA3182053=GCA_001403295 P9E7=CDZX01=SAMEA3182077=GCA_001403215 P9E90=CDTY01=SAMEA3182101=GCA_001409035 )
for equi in ${equis[@]}
do
    patientID=`echo $equi | cut -d '=' -f 1 | sed 's/\([EC]\)/_\1/'`
    if [[ ! $patientID =~ P3_.* ]]
    then 
        continue
    fi
    echo $patientID
    sampleID=`echo $equi | cut -d '=' -f 3`
    runIDs=`egrep "^PR" PRJEB8094.txt | grep ${sampleID} | cut -d$'\t' -f 5`
    for runID in ${runIDs[@]}
    do
        qsub -pe multiprocess 5 -N _bwa_merged ~/bin/dummy.sh bash -c "cat ${runID}_1.fastq >> mergedII/${patientID}_1.fastq"
        qsub -pe multiprocess 5 -N _bwa_merged ~/bin/dummy.sh bash -c "cat ${runID}_2.fastq >> mergedII/${patientID}_2.fastq"
    done
done



### Prefered way to concatenate the fastq files
equis=( P10E0=CDYI01=SAMEA3182054=GCA_001408995 P10E7=CDYF01=SAMEA3182078=GCA_001403175 P10E90=CDYK01=SAMEA3182102=GCA_001403255 P11E0=CDYG01=SAMEA3182055=GCA_001403435 P11E7=CDYJ01=SAMEA3182079=GCA_001408575 P11E90=CDYR01=SAMEA3182103=GCA_001408955 P12E0=CDYH01=SAMEA3182056=GCA_001408695 P12E7=CDYE01=SAMEA3182080=GCA_001408895 P12E90=CDYL01=SAMEA3182104=GCA_001409095 P13E0=CDYS01=SAMEA3182057=GCA_001408555 P13E7=CDYM01=SAMEA3182081=GCA_001403535 P13E90=CDYU01=SAMEA3182105=GCA_001282865 P14E0=CDYZ01=SAMEA3182058=GCA_001403415 P14E7=CDZA01=SAMEA3182082=GCA_001403335 P14E90=CDZB01=SAMEA3182106=GCA_001403495 P15E0=CDYQ01=SAMEA3182059=GCA_001408475 P15E7=CDYN01=SAMEA3182083=GCA_001403395 P15E90=CDYY01=SAMEA3182107=GCA_001282845 P17E0=CDYT01=SAMEA3182060=GCA_001408655 P17E7=CDYP01=SAMEA3182084=GCA_001408535 P17E90=CDZK01=SAMEA3182108=GCA_001408375 P18E0=CDYX01=SAMEA3182061=GCA_001403315 P18E7=CDZC01=SAMEA3182085=GCA_001408315 P18E90=CDZE01=SAMEA3182109=GCA_001408255 P19E0=CDZH01=SAMEA3182062=GCA_001409015 P19E7=CDZG01=SAMEA3182086=GCA_001409055 P19E90=CDZI01=SAMEA3182110=GCA_001403195 P1E0=CDTW01=SAMEA3182045=GCA_001403375 P1E7=CDZD01=SAMEA3182069=GCA_001403115 P1E90=CDZF01=SAMEA3182093=GCA_001408755 P20E0=CDZL01=SAMEA3182063=GCA_001408735 P20E7=CDZM01=SAMEA3182087=GCA_001408775 P20E90=CDZJ01=SAMEA3182111=GCA_001408355 P21E0=CDZP01=SAMEA3182064=GCA_001403455 P21E7=CDZO01=SAMEA3182088=GCA_001282745 P21E90=CDZQ01=SAMEA3182112=GCA_001403235 P22E0=CDZR01=SAMEA3182065=GCA_001403135 P22E7=CDZN01=SAMEA3182089=GCA_001408975 P22E90=CDZS01=SAMEA3182113=GCA_001409075 P23C0=CDZT01=SAMEA3182066=GCA_001408635 P23C7=CDZV01=SAMEA3182090=GCA_001403275 P23C90=CDZU01=SAMEA3182114=GCA_001408455 P25C0=CDZW01=SAMEA3182067=GCA_001408595 P25C7=CDZY01=SAMEA3182091=GCA_001408915 P25C90=CEAA01=SAMEA3182115=GCA_001408675 P2E0=CEAB01=SAMEA3182046=GCA_001408875 P2E7=CEBV01=SAMEA3182070=GCA_001403055 P2E90=CEAC01=SAMEA3182094=GCA_001408395 P38C0=CEAF01=SAMEA3182068=GCA_001408435 P38C7=CEAH01=SAMEA3182092=GCA_001408715 P38C90=CEAG01=SAMEA3182116=GCA_001403355 P3E0=CEAJ01=SAMEA3182047=GCA_001403515 P3E7=CEAK01=SAMEA3182071=GCA_001282825 P3E90=CEAL01=SAMEA3182095=GCA_001408615 P4E0=CEAM01=SAMEA3182048=GCA_001408415 P4E7=CECB01=SAMEA3182072=GCA_001403155 P4E90=CEAN01=SAMEA3182096=GCA_001403555 P5E0=CEAO01=SAMEA3182049=GCA_001408835 P5E7=CEAP01=SAMEA3182073=GCA_001409115 P5E90=CEAQ01=SAMEA3182097=GCA_001408795 P6C0=CEBY01=SAMEA3182050=GCA_001403035 P6C7=CEAZ01=SAMEA3182074=GCA_001408295 P6C90=CEAX01=SAMEA3182098=GCA_001403015 P7C0=CECA01=SAMEA3182051=GCA_001408275 P7C7=CEAR01=SAMEA3182075=GCA_001408495 P7C90=CECF01=SAMEA3182099=GCA_001403075 P8C0=CECJ01=SAMEA3182052=GCA_001408815 P8C7=CEAE01=SAMEA3182076=GCA_001403475 P8C90=CEAI01=SAMEA3182100=GCA_001408855 P9E0=CEAD01=SAMEA3182053=GCA_001403295 P9E7=CDZX01=SAMEA3182077=GCA_001403215 P9E90=CDTY01=SAMEA3182101=GCA_001409035 )
for equi in ${equis[@]}
do
    patientsArray_1=()
    patientsArray_2=()
    patientID=`echo $equi | cut -d '=' -f 1 | sed 's/\([EC]\)/_\1/'`
    if [[ ! $patientID =~ P3_E.* ]]
    then 
        continue
    fi
    echo $patientID
    sampleID=`echo $equi | cut -d '=' -f 3`
    runIDs=`egrep "^PR" PRJEB8094.txt | grep ${sampleID} | cut -d$'\t' -f 5`
    for runID in ${runIDs[@]}
    do
        patientsArray_1+=("${runID}_1.fastq")
        patientsArray_2+=("${runID}_2.fastq")
    done
#    echo ${patientsArray_1[@]}
    echo "cat ${patientsArray_1[@]} > mergedII/${patientID}_1.fastq"
    echo "cat ${patientsArray_2[@]} > mergedII/${patientID}_2.fastq"
done




### Script to map the fatq reads to reference using bwa === for MERGED fastq Files
# module load bwa
sampleNum=`ls mergedFastq/ | grep ".*fastq" | cut -d '_' -f 1,2 | sort | uniq`
genomeHandle="/shares/home/users/augerjer/PRJEB8094/elen_DSM2243/elen_DSM2243_genome.fna"
for num in ${sampleNum[@]}
do
    num_1=`ls mergedFastq/ | grep "$num"_1.fastq`
    num_2=`ls mergedFastq/ | grep "$num"_2.fastq`
    if [ ! -e samOut/${num}.sam ]
    then
        qsub -pe multiprocess 5 -N _bwa_merged ~/bin/dummy.sh bash -c "bwa mem -t 5 ${genomeHandle} mergedFastq/${num_1} mergedFastq/${num_2} > samOut/${num}_DSM2243.sam"
    else
        echo "file $num already exists"
    fi
done




sampleNum=`ls mergedFastq/ | grep ".*fastq" | cut -d '_' -f 1,2 | sort | uniq`
genomeHandle="/shares/home/users/augerjer/PRJEB8094/elen_DSM2243/elen_DSM2243_genome.fna"
for num in ${sampleNum[@]}
do
    num_1=`ls mergedFastq/ | grep "$num"_1.fastq`
    num_2=`ls mergedFastq/ | grep "$num"_2.fastq`
    if [[ $num =~ P3_E7 ]]
    then
        echo "bwa mem -t 5 ${genomeHandle} mergedFastq/${num_1} mergedFastq/${num_2} > samOut/${num}_DSM2243.sam"
        #qsub -pe multiprocess 5 -N _bwa_merged ~/bin/dummy.sh bash -c "bwa mem -t 5 ${genomeHandle} mergedFastq/${num_1} mergedFastq/${num_2} > samOut/${num}_DSM2243.sam"
    fi
done


qsub -pe multiprocess 5 -N _bwa_merged ~/bin/dummy.sh bash -c "bwa mem -t 5 /shares/home/users/augerjer/PRJEB8094/elen_DSM2243/elen_DSM2243_genome.fna mergedFastq/P3_E7_1.fastq mergedFastq/P3_E7_2.fastq > samOut/P3_E7_DSM2243.sam"


java -jarpicard.jar MergeSamFiles I=test/fastq/sample_1_01.sam I=test/fastq/sample_1_02.sam SO=coordinate O=test/fastq/sample_1.bam AS=false
java -jar /opt/picard-tools-2.1.1/jar/picard.jar 


java -jar /opt/picard-tools-2.1.1/jar/picard.jar CollectHsMetrics
java -jar /opt/picard-tools-2.1.1/jar/picard.jar HsMetrics


samFiles=`ls | egrep "P.*\II.sam"`
for samFile in ${samFiles[@]}
do
    samFile=`echo $samFile | sed s/....$//`
    echo "qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh bash -c \"samtools view -b -F 4 ${samFile}.sam > ${samFile}_mapped.bam\""
done

samtools view -b -F 4 file.bam > mapped.bam


echo $samFile | sed s/....$// 


qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh bash -c "samtools view -b -F 4 P3_E0_DSM2243-II.sam > P3_E0_DSM2243-II_mapped.bam"
qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh bash -c "samtools view -b -F 4 P3_E7_DSM2243-II.sam > P3_E7_DSM2243-II_mapped.bam"
qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh bash -c "samtools view -b -F 4 P3_E90_DSM2243-II.sam > P3_E90_DSM2243-II_mapped.bam"


java -jar /opt/picard-tools-2.1.1/jar/picard.jar CreateSequenceDictionary R= elen_DSM2243_genome.fna O= elen_DSM2243_genome.dict

from Bio import SeqIO
SeqIO.convert("elen_DSM2243_genome.fna", "fasta", "elen_DSM2243_genomeII.fna", "fasta")

samtools faidx elen_DSM2243_genome.fna

samtools sort P3_E0_DSM2243-II_mapped.bam > P3_E0_DSM2243-II_mapped_sorted.bam
samtools sort P3_E0_DSM2243-II_mapped.bam > P3_E7_DSM2243-II_mapped_sorted.bam
samtools sort P3_E0_DSM2243-II_mapped.bam > P3_E90_DSM2243-II_mapped_sorted.bam

samtools index P3_E0_DSM2243-II_mapped_sorted.bam

$ bwa mem  ref.fasta f1.fq.gz f2.fq.gz | samtools view  -Sb - | samtools sort - sorted && samtools index sorted.bam

samtools view -b P3_E0_DSM2243-II.sam > test.bam
samtools sort P3_E7_DSM2243-II_mapped.bam -o sorted.bam && samtools index sorted.bam

samtools sort P3_E7_DSM2243-II_mapped.bam -o sorted.bam


qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh samtools sort P3_E0_DSM2243-II_mapped.bam -o sortedP3E0.bam

samtools index sortedP3E0.bam

samtools view -F 12 P3_E0_DSM2243-II.sam | head -1000 | awk -F '\t' '{ print $6 }' | less -S 

samtools view -F 12 P3_E0_DSM2243-II.sam | awk -F '\t' '$6 == "101M" { print $0 }' | wc -l

#
samtools view -b -F 12 P3_E0_DSM2243-II.sam | bedtools bamtobed -cigar | awk -F '\t' '($3-$2 > 90) { print $0 }' 

qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh bash -c "samtools view -b -F 12 P3_E0_DSM2243.sam > P3_E0_DSM2243_F12.bam"
qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh bash -c "samtools view -b -F 12 P3_E7_DSM2243.sam > P3_E7_DSM2243_F12.bam"
qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh bash -c "samtools view -b -F 12 P3_E90_DSM2243.sam > P3_E90_DSM2243_F12.bam"


bedtools bamtobed -i P3_E0_DSM2243_F12.bam -cigar | awk -F '\t' '($3-$2 > 95) { print $4 }' > P3_E0_DSM2243_list.txt 
P3_E7_DSM2243_F12.bam 
P3_E90_DSM2243_F12.bam


### Script named testElenSpecificity.sh
#!/usr/bin/env bash


### To select the reads that matched properly (takes ~5min)
samtools view -b -f 2 P3_E0_DSM2243.sam > P3_E0_DSM2243_f2.bam
#qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh bash -c "samtools view -b -F 12 P3_E0_DSM2243.sam > P3_E0_DSM2243_F12.bam"
### To select the reads that match over a certain length (fast)
bedtools bamtobed -i P3_E0_DSM2243_f2.bam -cigar | awk -F '\t' '($3-$2 > 90) { print $4 }' > P3_E0_DSM2243_f2_CutOff-90.txt 

filename="P3_E0_DSM2243_f2_CutOff-90.txt"
while read -r line
do
    runNb=`echo $line | cut -d '.' -f 1`
    readNb=`echo $line | cut -d '.' -f 2 | cut -d '/' -f 1`
    forward_reverse=`echo $line | cut -d '/' -f 2`
    cat "../${runNb}_${forward_reverse}.fastq" | sed -n "/@${runNb}.${readNb} /{p;n;p}" >> f2_cut90_ElenSpecReads.txt
    #echo "@${runNb}.${readNb}"
done < "$filename"

### Line to submit it to the queue
qsub -pe multiprocess 5 -N _samToBam ~/bin/dummy.sh bash -c "testElenSpecificity.sh"
#cat "../${runNb}_${forward_reverse}.fastq" | sed -n "/@${runNb}.${readNb} /{p;n;p}" >> testElenSpecReads.txt
#qsub -N _blastKmers ~/bin/dummy.sh bash -c "python blastKmers.py 2>>15novErrorLog.txt"


###Blasting the elen DSN2243 on local database
qsub -pe multiprocess 16 -N _blastKmers ~/bin/dummy.sh bash -c "blastn -query 'DSM2243_toKmers.fna' -db 'refGenomeDB/allGenomes.fna' -out elenSpecificKmers.txt -word_size 7 -outfmt 6 -num_threads 16"

cat elenSpecificKmers.txt | cut -f 1 | sort -n -k1.3 | uniq -c > elenSpecificCounts.txt

# for K-31-DSM2243.fna
qsub -pe multiprocess 16 -N _blastKmers ~/bin/dummy.sh bash -c "blastn -query 'K-31-DSM2243.fna' -db 'refGenomeDB/allGenomes.fna' -out elenSpecificK-31.txt -word_size 7 -outfmt 6 -num_threads 16 -perc_identity 100 -qcov_hsp_perc 100"
cat elenSpecificK-31.txt | cut -f 1 | sort -n -k1.3 | uniq -c > elenSpecificK-31.txt

# Remaking blastn --> with shorter 21ncl k-mers - hopint for less specificity
qsub -pe multiprocess 16 -N _blastKmers ~/bin/dummy.sh bash -c "blastn -query 'K-21-DSM2243.fna' -db 'refGenomeDB/allGenomes.fna' -out elenSpecificK-21.txt -word_size 7 -outfmt 6 -num_threads 16 -perc_identity 100 -qcov_hsp_perc 100"
cat elenSpecificK-31.txt | cut -f 1 | sort -n -k1.3 | uniq -c > elenSpecificK-21.txt


### Making the metagenome with ELenta and the other actinobact
cat *fna > metagenome.fna
### IMPORTANT ### to remove the errors from files batch downloaded from Blast website
egrep -v "^NCBI|^    Error" metagenome.fna > temp && mv temp metagenome.fna

# generating the fai and dict (From "http://gatkforums.broadinstitute.org/gatk/discussion/1601/how-can-i-prepare-a-fasta-file-to-use-as-reference")
# creating the .dict ("java -jar CreateSequenceDictionary.jar R= Homo_sapiens_assembly18.fasta O= Homo_sapiens_assembly18.dict")
java -jar /opt/picard-tools-2.1.1/jar/picard.jar CreateSequenceDictionary R=metagenome.fna O=metagenome.dict
# creating the fasta index file "samtools faidx Homo_sapiens_assembly18.fasta"
samtools faidx metagenome.fna

qsub -pe multiprocess 5 -N _bwaIndex ~/bin/dummy.sh bash -c "bwa index metagenome.fna"

sampleNum=` ls ../../fastq/mergedII/ | grep ".*fastq" | cut -d '_' -f 1,2 | sort | uniq`
genomeHandle=`find -name "metagenome.fna"`
for num in ${sampleNum[@]}
do
    num_1=`ls ../../fastq/mergedII/ | grep "$num"_1.fastq`
    num_2=`ls ../../fastq/mergedII/ | grep "$num"_2.fastq`
    if [[ $num =~ P3_E ]]
    then
        echo "qsub -pe multiprocess 5 -N _bwaMeta ~/bin/dummy.sh bash -c \"bwa mem -t 5 ${genomeHandle} ../../fastq/mergedII/${num_1} ../../fastq/mergedII/${num_2} > samMeta/${num}_Meta.sam\""
    fi
done

qsub -pe multiprocess 5 -N _bwaMeta ~/bin/dummy.sh bash -c "bwa mem -t 5 ./metagenome.fna ../../fastq/mergedII/P3_E0_1.fastq ../../fastq/mergedII/P3_E0_2.fastq > samMeta/P3_E0_Meta.sam"
qsub -pe multiprocess 5 -N _bwaMeta ~/bin/dummy.sh bash -c "bwa mem -t 5 ./metagenome.fna ../../fastq/mergedII/P3_E7_1.fastq ../../fastq/mergedII/P3_E7_2.fastq > samMeta/P3_E7_Meta.sam"
qsub -pe multiprocess 5 -N _bwaMeta ~/bin/dummy.sh bash -c "bwa mem -t 5 ./metagenome.fna ../../fastq/mergedII/P3_E90_1.fastq ../../fastq/mergedII/P3_E90_2.fastq > samMeta/P3_E90_Meta.sam"



# Creating the alignments
qsub -pe multiprocess 5 -N _bwaMetagenome ~/bin/dummy.sh bash -c "bwa mem -t 5 metagenome.fna ../../fastq/mergedII/P3_E7_1.fastq ../../fastq/mergedII/P3_E7_2.fastq > samMeta/P3_E7_metagenome.sam"


### For the metagenomic alignment SAMs to be sorted and usable by IGV
for file in `ls *Meta.sam`
do
    echo "qsub -pe multiprocess 5 -N _samIndex ~/bin/dummy.sh bash -c \"samtools view -b -S ${file} > ${file::-4}.bam && samtools sort ${file::-4}.bam -o ${file::-4}_sort.bam && samtools index ${file::-4}_sort.bam\""
done


qsub -pe multiprocess 5 -N _samIndex ~/bin/dummy.sh bash -c "samtools view -b -S P3_E0_Meta.sam > P3_E0_Meta.bam && samtools sort P3_E0_Meta.bam -o P3_E0_Meta_sort.bam && samtools index P3_E0_Meta_sort.bam"
qsub -pe multiprocess 5 -N _samIndex ~/bin/dummy.sh bash -c "samtools view -b -S P3_E7_Meta.sam > P3_E7_Meta.bam && samtools sort P3_E7_Meta.bam -o P3_E7_Meta_sort.bam && samtools index P3_E7_Meta_sort.bam"
qsub -pe multiprocess 5 -N _samIndex ~/bin/dummy.sh bash -c "samtools view -b -S P3_E90_Meta.sam > P3_E90_Meta.bam && samtools sort P3_E90_Meta.bam -o P3_E90_Meta_sort.bam && samtools index P3_E90_Meta_sort.bam"


samtools view -f 2 -h -b P3_E0_Meta.bam > P3_E0_Meta_f2.bam
bedtools bamtobed -i P3_E0_Meta_f2.bam -cigar | awk -F '\t' '($3-$2 > 90) { print $4 }' > P3_E0_DSM2243_f2_Meta_List.txt 

filename="P3_E0_DSM2243_f2_Meta_List.txt"
while read -r line
do
    runNb=`echo $line | cut -d '.' -f 1`
    readNb=`echo $line | cut -d '.' -f 2 | cut -d '/' -f 1`
    forward_reverse=`echo $line | cut -d '/' -f 2`
    cat "../../../fastq/${runNb}_${forward_reverse}.fastq" | sed -n "/^@${runNb}.${readNb} /{p;n;p;q}" >> f2_Meta_cut90_ElenSpecReads.txt
    #echo "@${runNb}.${readNb}"
done < "$filename"



### For the fastq BWA against the Metagenome --> selecting the reads that mapped againts the ELenta genome
samtools view -f 2 -h P3_E0_Meta.bam | grep "^@\|\sCP001726.1\s" > P3_E0_Meta_f2_OnlyElen.sam
samtools view -h -b P3_E0_Meta_f2_OnlyElen.sam > P3_E0_Meta_f2_OnlyElen.bam
bedtools bamtobed -i P3_E0_Meta_f2_OnlyElen.bam -cigar | awk -F '\t' '($3-$2 > 90) { print $4 }' > P3_E0_DSM2243_Meta_f2_ELenOnly_List.txt 

filename="P3_E0_DSM2243_Meta_f2_ELenOnly_List.txt"
while read -r line
do
    runNb=`echo $line | cut -d '.' -f 1`
    readNb=`echo $line | cut -d '.' -f 2 | cut -d '/' -f 1`
    forward_reverse=`echo $line | cut -d '/' -f 2`
    cat "../../../fastq/${runNb}_${forward_reverse}.fastq" | sed -n "/^@${runNb}.${readNb} /{p;n;p;q}" >> f2_Meta_cut90_ElenSpecReads.txt
    #echo "@${runNb}.${readNb}"
done < "$filename"



### Other way to extract the fastq that mapped against ELenta genome (needs to be on sorted bam file)
samtools view -f 2 -h -b P3_E0_Meta_sort.bam CP001726.1 > sortedToList.bam
bedtools bamtobed -i sortedToList.bam -cigar | awk -F '\t' '($3-$2 > 90) { print $4 }' > sorted_List.txt 


filename="sorted_List.txt"
while read -r line
do
    runNb=`echo $line | cut -d '.' -f 1`
    readNb=`echo $line | cut -d '.' -f 2 | cut -d '/' -f 1`
    forward_reverse=`echo $line | cut -d '/' -f 2`
    cat "../../../fastq/${runNb}_${forward_reverse}.fastq" | sed -n "/^@${runNb}.${readNb} /{p;n;p;q}" >> sorted_List_Reads.txt
done < "$filename"


for hitsList in `ls | grep "HitsList.txt"`
do 
    while read -r line
    do
        runNb=`echo $line | cut -d '.' -f 1`
        readNb=`echo $line | cut -d '.' -f 2 | cut -d '/' -f 1`
        forward_reverse=`echo $line | cut -d '/' -f 2`
        grep -A 1 -m 1 "^@${runNb}.${readNb}" "../fastq/${runNb}_${forward_reverse}.fastq" | tr "@" ">" #>> ${hitsList::-4}_MappedReads.fna
    done < "$hitsList"
done



#=============================================================================================================================
# Script to download the fastq associated with a single patient, concatenate and unzip them
#=============================================================================================================================

equis=( P10E0=CDYI01=SAMEA3182054=GCA_001408995 P10E7=CDYF01=SAMEA3182078=GCA_001403175 P10E90=CDYK01=SAMEA3182102=GCA_001403255 P11E0=CDYG01=SAMEA3182055=GCA_001403435 P11E7=CDYJ01=SAMEA3182079=GCA_001408575 P11E90=CDYR01=SAMEA3182103=GCA_001408955 P12E0=CDYH01=SAMEA3182056=GCA_001408695 P12E7=CDYE01=SAMEA3182080=GCA_001408895 P12E90=CDYL01=SAMEA3182104=GCA_001409095 P13E0=CDYS01=SAMEA3182057=GCA_001408555 P13E7=CDYM01=SAMEA3182081=GCA_001403535 P13E90=CDYU01=SAMEA3182105=GCA_001282865 P14E0=CDYZ01=SAMEA3182058=GCA_001403415 P14E7=CDZA01=SAMEA3182082=GCA_001403335 P14E90=CDZB01=SAMEA3182106=GCA_001403495 P15E0=CDYQ01=SAMEA3182059=GCA_001408475 P15E7=CDYN01=SAMEA3182083=GCA_001403395 P15E90=CDYY01=SAMEA3182107=GCA_001282845 P17E0=CDYT01=SAMEA3182060=GCA_001408655 P17E7=CDYP01=SAMEA3182084=GCA_001408535 P17E90=CDZK01=SAMEA3182108=GCA_001408375 P18E0=CDYX01=SAMEA3182061=GCA_001403315 P18E7=CDZC01=SAMEA3182085=GCA_001408315 P18E90=CDZE01=SAMEA3182109=GCA_001408255 P19E0=CDZH01=SAMEA3182062=GCA_001409015 P19E7=CDZG01=SAMEA3182086=GCA_001409055 P19E90=CDZI01=SAMEA3182110=GCA_001403195 P1E0=CDTW01=SAMEA3182045=GCA_001403375 P1E7=CDZD01=SAMEA3182069=GCA_001403115 P1E90=CDZF01=SAMEA3182093=GCA_001408755 P20E0=CDZL01=SAMEA3182063=GCA_001408735 P20E7=CDZM01=SAMEA3182087=GCA_001408775 P20E90=CDZJ01=SAMEA3182111=GCA_001408355 P21E0=CDZP01=SAMEA3182064=GCA_001403455 P21E7=CDZO01=SAMEA3182088=GCA_001282745 P21E90=CDZQ01=SAMEA3182112=GCA_001403235 P22E0=CDZR01=SAMEA3182065=GCA_001403135 P22E7=CDZN01=SAMEA3182089=GCA_001408975 P22E90=CDZS01=SAMEA3182113=GCA_001409075 P23C0=CDZT01=SAMEA3182066=GCA_001408635 P23C7=CDZV01=SAMEA3182090=GCA_001403275 P23C90=CDZU01=SAMEA3182114=GCA_001408455 P25C0=CDZW01=SAMEA3182067=GCA_001408595 P25C7=CDZY01=SAMEA3182091=GCA_001408915 P25C90=CEAA01=SAMEA3182115=GCA_001408675 P2E0=CEAB01=SAMEA3182046=GCA_001408875 P2E7=CEBV01=SAMEA3182070=GCA_001403055 P2E90=CEAC01=SAMEA3182094=GCA_001408395 P38C0=CEAF01=SAMEA3182068=GCA_001408435 P38C7=CEAH01=SAMEA3182092=GCA_001408715 P38C90=CEAG01=SAMEA3182116=GCA_001403355 P3E0=CEAJ01=SAMEA3182047=GCA_001403515 P3E7=CEAK01=SAMEA3182071=GCA_001282825 P3E90=CEAL01=SAMEA3182095=GCA_001408615 P4E0=CEAM01=SAMEA3182048=GCA_001408415 P4E7=CECB01=SAMEA3182072=GCA_001403155 P4E90=CEAN01=SAMEA3182096=GCA_001403555 P5E0=CEAO01=SAMEA3182049=GCA_001408835 P5E7=CEAP01=SAMEA3182073=GCA_001409115 P5E90=CEAQ01=SAMEA3182097=GCA_001408795 P6C0=CEBY01=SAMEA3182050=GCA_001403035 P6C7=CEAZ01=SAMEA3182074=GCA_001408295 P6C90=CEAX01=SAMEA3182098=GCA_001403015 P7C0=CECA01=SAMEA3182051=GCA_001408275 P7C7=CEAR01=SAMEA3182075=GCA_001408495 P7C90=CECF01=SAMEA3182099=GCA_001403075 P8C0=CECJ01=SAMEA3182052=GCA_001408815 P8C7=CEAE01=SAMEA3182076=GCA_001403475 P8C90=CEAI01=SAMEA3182100=GCA_001408855 P9E0=CEAD01=SAMEA3182053=GCA_001403295 P9E7=CDZX01=SAMEA3182077=GCA_001403215 P9E90=CDTY01=SAMEA3182101=GCA_001409035 )
ftpURLs=()
for equi in ${equis[@]}
do
    patientID=`echo $equi | cut -d '=' -f 1`
    samID=`echo $equi | cut -d '=' -f 3`
    if [[ $patientID =~ P4[EC].* ]]
    then
        ftpURLs+=(`grep ${samID} PRJEB8094.txt | cut -d$'\t' -f 10 | tr ';' '\n'`)
    fi
done

qsub -pe multiprocess 5 -N _wgetP6 ~/bin/dummy.sh bash -c "printf \"%s\n\" ${ftpURLs[@]} | xargs -I {} -n 1 -P 5 wget -q -c {}"
### Had to launch manually through qlogin
#printf "%s\n" ${ftpURLs[@]} | xargs -I {} -n 1 -P 5 wget -q -c {} &


qsub -pe multiprocess 16 -N _wgetFastq -l walltime=60:00:00 ~/bin/dummy.sh bash -c "grep '^PR' PRJEB8094.txt | cut -d$'\t' -f 10 | tr ';' '\n' | xargs -I {} -n 1 -P 16 wget -q -c {}"

qsub 

# manually moving the downloaded files to the fastq directory
mkdir fastq
mv *fastq.* fastq/

# making the merged and the alignments folder
mkdir merged
mkdir alignments

### Concatenating the gzipped fastq files; then unzipping the merged *** takes about 15 min per patient
equis=( P10E0=CDYI01=SAMEA3182054=GCA_001408995 P10E7=CDYF01=SAMEA3182078=GCA_001403175 P10E90=CDYK01=SAMEA3182102=GCA_001403255 P11E0=CDYG01=SAMEA3182055=GCA_001403435 P11E7=CDYJ01=SAMEA3182079=GCA_001408575 P11E90=CDYR01=SAMEA3182103=GCA_001408955 P12E0=CDYH01=SAMEA3182056=GCA_001408695 P12E7=CDYE01=SAMEA3182080=GCA_001408895 P12E90=CDYL01=SAMEA3182104=GCA_001409095 P13E0=CDYS01=SAMEA3182057=GCA_001408555 P13E7=CDYM01=SAMEA3182081=GCA_001403535 P13E90=CDYU01=SAMEA3182105=GCA_001282865 P14E0=CDYZ01=SAMEA3182058=GCA_001403415 P14E7=CDZA01=SAMEA3182082=GCA_001403335 P14E90=CDZB01=SAMEA3182106=GCA_001403495 P15E0=CDYQ01=SAMEA3182059=GCA_001408475 P15E7=CDYN01=SAMEA3182083=GCA_001403395 P15E90=CDYY01=SAMEA3182107=GCA_001282845 P17E0=CDYT01=SAMEA3182060=GCA_001408655 P17E7=CDYP01=SAMEA3182084=GCA_001408535 P17E90=CDZK01=SAMEA3182108=GCA_001408375 P18E0=CDYX01=SAMEA3182061=GCA_001403315 P18E7=CDZC01=SAMEA3182085=GCA_001408315 P18E90=CDZE01=SAMEA3182109=GCA_001408255 P19E0=CDZH01=SAMEA3182062=GCA_001409015 P19E7=CDZG01=SAMEA3182086=GCA_001409055 P19E90=CDZI01=SAMEA3182110=GCA_001403195 P1E0=CDTW01=SAMEA3182045=GCA_001403375 P1E7=CDZD01=SAMEA3182069=GCA_001403115 P1E90=CDZF01=SAMEA3182093=GCA_001408755 P20E0=CDZL01=SAMEA3182063=GCA_001408735 P20E7=CDZM01=SAMEA3182087=GCA_001408775 P20E90=CDZJ01=SAMEA3182111=GCA_001408355 P21E0=CDZP01=SAMEA3182064=GCA_001403455 P21E7=CDZO01=SAMEA3182088=GCA_001282745 P21E90=CDZQ01=SAMEA3182112=GCA_001403235 P22E0=CDZR01=SAMEA3182065=GCA_001403135 P22E7=CDZN01=SAMEA3182089=GCA_001408975 P22E90=CDZS01=SAMEA3182113=GCA_001409075 P23C0=CDZT01=SAMEA3182066=GCA_001408635 P23C7=CDZV01=SAMEA3182090=GCA_001403275 P23C90=CDZU01=SAMEA3182114=GCA_001408455 P25C0=CDZW01=SAMEA3182067=GCA_001408595 P25C7=CDZY01=SAMEA3182091=GCA_001408915 P25C90=CEAA01=SAMEA3182115=GCA_001408675 P2E0=CEAB01=SAMEA3182046=GCA_001408875 P2E7=CEBV01=SAMEA3182070=GCA_001403055 P2E90=CEAC01=SAMEA3182094=GCA_001408395 P38C0=CEAF01=SAMEA3182068=GCA_001408435 P38C7=CEAH01=SAMEA3182092=GCA_001408715 P38C90=CEAG01=SAMEA3182116=GCA_001403355 P3E0=CEAJ01=SAMEA3182047=GCA_001403515 P3E7=CEAK01=SAMEA3182071=GCA_001282825 P3E90=CEAL01=SAMEA3182095=GCA_001408615 P4E0=CEAM01=SAMEA3182048=GCA_001408415 P4E7=CECB01=SAMEA3182072=GCA_001403155 P4E90=CEAN01=SAMEA3182096=GCA_001403555 P5E0=CEAO01=SAMEA3182049=GCA_001408835 P5E7=CEAP01=SAMEA3182073=GCA_001409115 P5E90=CEAQ01=SAMEA3182097=GCA_001408795 P6C0=CEBY01=SAMEA3182050=GCA_001403035 P6C7=CEAZ01=SAMEA3182074=GCA_001408295 P6C90=CEAX01=SAMEA3182098=GCA_001403015 P7C0=CECA01=SAMEA3182051=GCA_001408275 P7C7=CEAR01=SAMEA3182075=GCA_001408495 P7C90=CECF01=SAMEA3182099=GCA_001403075 P8C0=CECJ01=SAMEA3182052=GCA_001408815 P8C7=CEAE01=SAMEA3182076=GCA_001403475 P8C90=CEAI01=SAMEA3182100=GCA_001408855 P9E0=CEAD01=SAMEA3182053=GCA_001403295 P9E7=CDZX01=SAMEA3182077=GCA_001403215 P9E90=CDTY01=SAMEA3182101=GCA_001409035 )
for equi in ${equis[@]}
do
    patientsArray_1=()
    patientsArray_2=()
    patientID=`echo $equi | cut -d '=' -f 1 | sed 's/\([EC]\)/_\1/'`
    if [[ ! $patientID =~ P4.* ]]
    then 
        continue
    fi
    #echo $patientID
    sampleID=`echo $equi | cut -d '=' -f 3`
    runIDs=`grep ${sampleID} PRJEB8094.txt | cut -d$'\t' -f 5`
    for runID in ${runIDs[@]}
    do
        patientsArray_1+=("./fastq/${runID}_1.fastq.gz")
        patientsArray_2+=("./fastq/${runID}_2.fastq.gz")
    done
    #echo ${patientsArray_1[@]}
    echo "qsub -N _fastaMerge ~/bin/dummy.sh bash -c \"cat ${patientsArray_1[@]} > merged/${patientID}_1.fastq.gz\""
    echo "qsub -N _fastaMerge ~/bin/dummy.sh bash -c \"cat ${patientsArray_2[@]} > merged/${patientID}_2.fastq.gz\""
done

### Then unzip the concatenated fastq
find ./merged -name "*gz" | xargs -P 3 gunzip &

#================================================================================================================================
# Script to align against the metagenome 
#================================================================================================================================

sampleNum=`ls ./merged | grep ".*fastq" | cut -d '_' -f 1,2 | sort | uniq`
genomeHandle="/shares/home/users/augerjer/PRJEB8094/elenSpecific/metagenome/metagenome.fna"
for num in ${sampleNum[@]}
do
    num_1="${num}_1.fastq"
    num_2="${num}_2.fastq"
    if [[ $num =~ P4_[EC] ]]
    then
        fastq1="./merged/${num}_1.fastq"
        fastq2="./merged/${num}_2.fastq"
        echo "qsub -pe multiprocess 5 -N _bwaMeta ~/bin/dummy.sh bash -c \"bwa mem -t 5 ${genomeHandle} ${fastq1} ${fastq2} > alignments/${num}_meta.sam\""
    fi
done 

qsub -pe multiprocess 5 -N _bwaMeta ~/bin/dummy.sh bash -c "bwa mem -t 5 /shares/home/users/augerjer/PRJEB8094/elenSpecific/metagenome/metagenome.fna ./merged/P6_C0_1.fastq ./merged/P6_C0_2.fastq > alignments/P6_C0_meta.sam"
qsub -pe multiprocess 5 -N _bwaMeta ~/bin/dummy.sh bash -c "bwa mem -t 5 /shares/home/users/augerjer/PRJEB8094/elenSpecific/metagenome/metagenome.fna ./merged/P6_C7_1.fastq ./merged/P6_C7_2.fastq > alignments/P6_C7_meta.sam"
qsub -pe multiprocess 5 -N _bwaMeta ~/bin/dummy.sh bash -c "bwa mem -t 5 /shares/home/users/augerjer/PRJEB8094/elenSpecific/metagenome/metagenome.fna ./merged/P6_C90_1.fastq ./merged/P6_C90_2.fastq > alignments/P6_C90_meta.sam"

#================================================================================================================================
# From aligned sam files, extracting the E. Lenta specific read numbers and count
#================================================================================================================================
### Generating the initial sorted and indexed bam files (takes some time)
# *** change to cd ./alignments *** #
for file in `ls *meta.sam`
do
    echo "qsub -pe multiprocess 5 -N _samIndex ~/bin/dummy.sh bash -c \"samtools view -b -S ${file} > ${file::-4}.bam && samtools sort ${file::-4}.bam -o ${file::-4}_sort.bam && samtools index ${file::-4}_sort.bam\""
done

### Starting with sorted and indexed bam files aligned on the metagenome local DB, 
### extracting the number of mapped reads that have more than 90 mapped nucleotides on the 101 pb reads (quite fast)

for inHandle in `ls | grep "\.bam\.bai"`
do 
    ID=`echo $inHandle | cut -d '_' -f 1,2`
    samtools view -f 2 -h -b ${inHandle::-4} CP001726.1 > ${ID}_f2_meta_1726.bam
    bedtools bamtobed -i ${ID}_f2_meta_1726.bam -cigar | awk -F '\t' '($3-$2 > 90) { print $4 }' > ${ID}_meta_f2_1726_HitsList.txt
done











### Concatenating the fastq files *** takes about 15 min per patient
equis=( P10E0=CDYI01=SAMEA3182054=GCA_001408995 P10E7=CDYF01=SAMEA3182078=GCA_001403175 P10E90=CDYK01=SAMEA3182102=GCA_001403255 P11E0=CDYG01=SAMEA3182055=GCA_001403435 P11E7=CDYJ01=SAMEA3182079=GCA_001408575 P11E90=CDYR01=SAMEA3182103=GCA_001408955 P12E0=CDYH01=SAMEA3182056=GCA_001408695 P12E7=CDYE01=SAMEA3182080=GCA_001408895 P12E90=CDYL01=SAMEA3182104=GCA_001409095 P13E0=CDYS01=SAMEA3182057=GCA_001408555 P13E7=CDYM01=SAMEA3182081=GCA_001403535 P13E90=CDYU01=SAMEA3182105=GCA_001282865 P14E0=CDYZ01=SAMEA3182058=GCA_001403415 P14E7=CDZA01=SAMEA3182082=GCA_001403335 P14E90=CDZB01=SAMEA3182106=GCA_001403495 P15E0=CDYQ01=SAMEA3182059=GCA_001408475 P15E7=CDYN01=SAMEA3182083=GCA_001403395 P15E90=CDYY01=SAMEA3182107=GCA_001282845 P17E0=CDYT01=SAMEA3182060=GCA_001408655 P17E7=CDYP01=SAMEA3182084=GCA_001408535 P17E90=CDZK01=SAMEA3182108=GCA_001408375 P18E0=CDYX01=SAMEA3182061=GCA_001403315 P18E7=CDZC01=SAMEA3182085=GCA_001408315 P18E90=CDZE01=SAMEA3182109=GCA_001408255 P19E0=CDZH01=SAMEA3182062=GCA_001409015 P19E7=CDZG01=SAMEA3182086=GCA_001409055 P19E90=CDZI01=SAMEA3182110=GCA_001403195 P1E0=CDTW01=SAMEA3182045=GCA_001403375 P1E7=CDZD01=SAMEA3182069=GCA_001403115 P1E90=CDZF01=SAMEA3182093=GCA_001408755 P20E0=CDZL01=SAMEA3182063=GCA_001408735 P20E7=CDZM01=SAMEA3182087=GCA_001408775 P20E90=CDZJ01=SAMEA3182111=GCA_001408355 P21E0=CDZP01=SAMEA3182064=GCA_001403455 P21E7=CDZO01=SAMEA3182088=GCA_001282745 P21E90=CDZQ01=SAMEA3182112=GCA_001403235 P22E0=CDZR01=SAMEA3182065=GCA_001403135 P22E7=CDZN01=SAMEA3182089=GCA_001408975 P22E90=CDZS01=SAMEA3182113=GCA_001409075 P23C0=CDZT01=SAMEA3182066=GCA_001408635 P23C7=CDZV01=SAMEA3182090=GCA_001403275 P23C90=CDZU01=SAMEA3182114=GCA_001408455 P25C0=CDZW01=SAMEA3182067=GCA_001408595 P25C7=CDZY01=SAMEA3182091=GCA_001408915 P25C90=CEAA01=SAMEA3182115=GCA_001408675 P2E0=CEAB01=SAMEA3182046=GCA_001408875 P2E7=CEBV01=SAMEA3182070=GCA_001403055 P2E90=CEAC01=SAMEA3182094=GCA_001408395 P38C0=CEAF01=SAMEA3182068=GCA_001408435 P38C7=CEAH01=SAMEA3182092=GCA_001408715 P38C90=CEAG01=SAMEA3182116=GCA_001403355 P3E0=CEAJ01=SAMEA3182047=GCA_001403515 P3E7=CEAK01=SAMEA3182071=GCA_001282825 P3E90=CEAL01=SAMEA3182095=GCA_001408615 P4E0=CEAM01=SAMEA3182048=GCA_001408415 P4E7=CECB01=SAMEA3182072=GCA_001403155 P4E90=CEAN01=SAMEA3182096=GCA_001403555 P5E0=CEAO01=SAMEA3182049=GCA_001408835 P5E7=CEAP01=SAMEA3182073=GCA_001409115 P5E90=CEAQ01=SAMEA3182097=GCA_001408795 P6C0=CEBY01=SAMEA3182050=GCA_001403035 P6C7=CEAZ01=SAMEA3182074=GCA_001408295 P6C90=CEAX01=SAMEA3182098=GCA_001403015 P7C0=CECA01=SAMEA3182051=GCA_001408275 P7C7=CEAR01=SAMEA3182075=GCA_001408495 P7C90=CECF01=SAMEA3182099=GCA_001403075 P8C0=CECJ01=SAMEA3182052=GCA_001408815 P8C7=CEAE01=SAMEA3182076=GCA_001403475 P8C90=CEAI01=SAMEA3182100=GCA_001408855 P9E0=CEAD01=SAMEA3182053=GCA_001403295 P9E7=CDZX01=SAMEA3182077=GCA_001403215 P9E90=CDTY01=SAMEA3182101=GCA_001409035 )
for equi in ${equis[@]}
do
    patientsArray_1=()
    patientsArray_2=()
    patientID=`echo $equi | cut -d '=' -f 1 | sed 's/\([EC]\)/_\1/'`
    if [[ ! $patientID =~ P21.* ]]
    then 
        continue
    fi
    #echo $patientID
    sampleID=`echo $equi | cut -d '=' -f 3`
    runIDs=`grep ${sampleID} PRJEB8094.txt | cut -d$'\t' -f 5`
    for runID in ${runIDs[@]}
    do
        patientsArray_1+=("./fastq/${runID}_1.fastq")
        patientsArray_2+=("./fastq/${runID}_2.fastq")
    done
    #echo ${patientsArray_1[@]}
    echo "qsub -N _fastaMerge ~/bin/dummy.sh bash -c \"cat ${patientsArray_1[@]} > merged/${patientID}_1.fastq\""
    echo "qsub -N _fastaMerge ~/bin/dummy.sh bash -c \"cat ${patientsArray_2[@]} > merged/${patientID}_2.fastq\""
done


#Getting the fastq from this patient to his own dir
equis=( P10E0=CDYI01=SAMEA3182054=GCA_001408995 P10E7=CDYF01=SAMEA3182078=GCA_001403175 P10E90=CDYK01=SAMEA3182102=GCA_001403255 P11E0=CDYG01=SAMEA3182055=GCA_001403435 P11E7=CDYJ01=SAMEA3182079=GCA_001408575 P11E90=CDYR01=SAMEA3182103=GCA_001408955 P12E0=CDYH01=SAMEA3182056=GCA_001408695 P12E7=CDYE01=SAMEA3182080=GCA_001408895 P12E90=CDYL01=SAMEA3182104=GCA_001409095 P13E0=CDYS01=SAMEA3182057=GCA_001408555 P13E7=CDYM01=SAMEA3182081=GCA_001403535 P13E90=CDYU01=SAMEA3182105=GCA_001282865 P14E0=CDYZ01=SAMEA3182058=GCA_001403415 P14E7=CDZA01=SAMEA3182082=GCA_001403335 P14E90=CDZB01=SAMEA3182106=GCA_001403495 P15E0=CDYQ01=SAMEA3182059=GCA_001408475 P15E7=CDYN01=SAMEA3182083=GCA_001403395 P15E90=CDYY01=SAMEA3182107=GCA_001282845 P17E0=CDYT01=SAMEA3182060=GCA_001408655 P17E7=CDYP01=SAMEA3182084=GCA_001408535 P17E90=CDZK01=SAMEA3182108=GCA_001408375 P18E0=CDYX01=SAMEA3182061=GCA_001403315 P18E7=CDZC01=SAMEA3182085=GCA_001408315 P18E90=CDZE01=SAMEA3182109=GCA_001408255 P19E0=CDZH01=SAMEA3182062=GCA_001409015 P19E7=CDZG01=SAMEA3182086=GCA_001409055 P19E90=CDZI01=SAMEA3182110=GCA_001403195 P1E0=CDTW01=SAMEA3182045=GCA_001403375 P1E7=CDZD01=SAMEA3182069=GCA_001403115 P1E90=CDZF01=SAMEA3182093=GCA_001408755 P20E0=CDZL01=SAMEA3182063=GCA_001408735 P20E7=CDZM01=SAMEA3182087=GCA_001408775 P20E90=CDZJ01=SAMEA3182111=GCA_001408355 P21E0=CDZP01=SAMEA3182064=GCA_001403455 P21E7=CDZO01=SAMEA3182088=GCA_001282745 P21E90=CDZQ01=SAMEA3182112=GCA_001403235 P22E0=CDZR01=SAMEA3182065=GCA_001403135 P22E7=CDZN01=SAMEA3182089=GCA_001408975 P22E90=CDZS01=SAMEA3182113=GCA_001409075 P23C0=CDZT01=SAMEA3182066=GCA_001408635 P23C7=CDZV01=SAMEA3182090=GCA_001403275 P23C90=CDZU01=SAMEA3182114=GCA_001408455 P25C0=CDZW01=SAMEA3182067=GCA_001408595 P25C7=CDZY01=SAMEA3182091=GCA_001408915 P25C90=CEAA01=SAMEA3182115=GCA_001408675 P2E0=CEAB01=SAMEA3182046=GCA_001408875 P2E7=CEBV01=SAMEA3182070=GCA_001403055 P2E90=CEAC01=SAMEA3182094=GCA_001408395 P38C0=CEAF01=SAMEA3182068=GCA_001408435 P38C7=CEAH01=SAMEA3182092=GCA_001408715 P38C90=CEAG01=SAMEA3182116=GCA_001403355 P3E0=CEAJ01=SAMEA3182047=GCA_001403515 P3E7=CEAK01=SAMEA3182071=GCA_001282825 P3E90=CEAL01=SAMEA3182095=GCA_001408615 P4E0=CEAM01=SAMEA3182048=GCA_001408415 P4E7=CECB01=SAMEA3182072=GCA_001403155 P4E90=CEAN01=SAMEA3182096=GCA_001403555 P5E0=CEAO01=SAMEA3182049=GCA_001408835 P5E7=CEAP01=SAMEA3182073=GCA_001409115 P5E90=CEAQ01=SAMEA3182097=GCA_001408795 P6C0=CEBY01=SAMEA3182050=GCA_001403035 P6C7=CEAZ01=SAMEA3182074=GCA_001408295 P6C90=CEAX01=SAMEA3182098=GCA_001403015 P7C0=CECA01=SAMEA3182051=GCA_001408275 P7C7=CEAR01=SAMEA3182075=GCA_001408495 P7C90=CECF01=SAMEA3182099=GCA_001403075 P8C0=CECJ01=SAMEA3182052=GCA_001408815 P8C7=CEAE01=SAMEA3182076=GCA_001403475 P8C90=CEAI01=SAMEA3182100=GCA_001408855 P9E0=CEAD01=SAMEA3182053=GCA_001403295 P9E7=CDZX01=SAMEA3182077=GCA_001403215 P9E90=CDTY01=SAMEA3182101=GCA_001409035 )
for equi in ${equis[@]}
do
    patientsArray_1=()
    patientsArray_2=()
    patientID=`echo $equi | cut -d '=' -f 1 | sed 's/\([EC]\)/_\1/'`
    if [[ ! $patientID =~ P20.* ]]
    then 
        continue
    fi
    sampleID=`echo $equi | cut -d '=' -f 3`
    runIDs=`grep ${sampleID} ../../allFastq/PRJEB8094.txt | cut -d$'\t' -f 5`
    for runID in ${runIDs[@]}
    do
        patientsArray_1+=("./fastq/${runID}_1.fastq")
        patientsArray_2+=("./fastq/${runID}_2.fastq")
    done
    #echo $patientID
    #echo ${#patientsArray_1[@]}
    #echo ${#patientsArray_2[@]}
    #echo ${patientsArray_1[@]}
    #echo "qsub -N _fastaMerge ~/bin/dummy.sh bash -c \"cat ${patientsArray_1[@]} > merged/${patientID}_1.fastq\""
    #echo "qsub -N _fastaMerge ~/bin/dummy.sh bash -c \"cat ${patientsArray_2[@]} > merged/${patientID}_2.fastq\""
    echo "cat ${patientsArray_1[@]} > merged/${patientID}_1.fastq"
    echo "cat ${patientsArray_2[@]} > merged/${patientID}_2.fastq"
done
    
echo ${#patientsArray_1[@]}
echo ${#patientsArray_2[@]}



for equi in ${equis[@]}
do
    patientsArray_1=()
    patientsArray_2=()
    patientID=`echo $equi | cut -d '=' -f 1 | sed 's/\([EC]\)/_\1/'`
    if [[ ! $patientID =~ P20.* ]]
    then 
        continue
    fi
    sampleID=`echo $equi | cut -d '=' -f 3`
    runIDs=`grep ${sampleID} ../../allFastq/PRJEB8094.txt | cut -d$'\t' -f 5`
    for runID in ${runIDs[@]}
    do
        patientsArray_1+=("./fastq/${runID}_1.fastq")
        patientsArray_2+=("./fastq/${runID}_2.fastq")
    done
    echo "mv ${patientsArray_1[@]} > merged/${patientID}_1.fastq"
    echo "mv ${patientsArray_2[@]} > merged/${patientID}_2.fastq"
done



cat ./fastq/ERR719694_1.fastq ./fastq/ERR719695_1.fastq ./fastq/ERR719696_1.fastq ./fastq/ERR719697_1.fastq ./fastq/ERR719698_1.fastq ./fastq/ERR719699_1.fastq ./fastq/ERR719700_1.fastq ./fastq/ERR719701_1.fastq ./fastq/ERR719702_1.fastq ./fastq/ERR719703_1.fastq ./fastq/ERR719704_1.fastq ./fastq/ERR719705_1.fastq ./fastq/ERR719706_1.fastq ./fastq/ERR719707_1.fastq > merged/P20_E0_1.fastq
cat ./fastq/ERR719694_2.fastq ./fastq/ERR719695_2.fastq ./fastq/ERR719696_2.fastq ./fastq/ERR719697_2.fastq ./fastq/ERR719698_2.fastq ./fastq/ERR719699_2.fastq ./fastq/ERR719700_2.fastq ./fastq/ERR719701_2.fastq ./fastq/ERR719702_2.fastq ./fastq/ERR719703_2.fastq ./fastq/ERR719704_2.fastq ./fastq/ERR719705_2.fastq ./fastq/ERR719706_2.fastq ./fastq/ERR719707_2.fastq > merged/P20_E0_2.fastq
cat ./fastq/ERR719708_1.fastq ./fastq/ERR719709_1.fastq ./fastq/ERR719710_1.fastq ./fastq/ERR719711_1.fastq ./fastq/ERR719712_1.fastq ./fastq/ERR719713_1.fastq ./fastq/ERR719714_1.fastq ./fastq/ERR719715_1.fastq ./fastq/ERR719716_1.fastq ./fastq/ERR719717_1.fastq > merged/P20_E7_1.fastq
cat ./fastq/ERR719708_2.fastq ./fastq/ERR719709_2.fastq ./fastq/ERR719710_2.fastq ./fastq/ERR719711_2.fastq ./fastq/ERR719712_2.fastq ./fastq/ERR719713_2.fastq ./fastq/ERR719714_2.fastq ./fastq/ERR719715_2.fastq ./fastq/ERR719716_2.fastq ./fastq/ERR719717_2.fastq > merged/P20_E7_2.fastq
cat ./fastq/ERR719718_1.fastq ./fastq/ERR719719_1.fastq ./fastq/ERR719720_1.fastq ./fastq/ERR719721_1.fastq ./fastq/ERR719722_1.fastq ./fastq/ERR719723_1.fastq ./fastq/ERR719724_1.fastq ./fastq/ERR719725_1.fastq ./fastq/ERR719726_1.fastq ./fastq/ERR719727_1.fastq ./fastq/ERR719728_1.fastq ./fastq/ERR719729_1.fastq ./fastq/ERR719730_1.fastq ./fastq/ERR719731_1.fastq ./fastq/ERR719732_1.fastq ./fastq/ERR719733_1.fastq ./fastq/ERR719734_1.fastq ./fastq/ERR719735_1.fastq ./fastq/ERR719736_1.fastq ./fastq/ERR719737_1.fastq ./fastq/ERR719738_1.fastq ./fastq/ERR719739_1.fastq ./fastq/ERR719740_1.fastq > merged/P20_E90_1.fastq
cat ./fastq/ERR719718_2.fastq ./fastq/ERR719719_2.fastq ./fastq/ERR719720_2.fastq ./fastq/ERR719721_2.fastq ./fastq/ERR719722_2.fastq ./fastq/ERR719723_2.fastq ./fastq/ERR719724_2.fastq ./fastq/ERR719725_2.fastq ./fastq/ERR719726_2.fastq ./fastq/ERR719727_2.fastq ./fastq/ERR719728_2.fastq ./fastq/ERR719729_2.fastq ./fastq/ERR719730_2.fastq ./fastq/ERR719731_2.fastq ./fastq/ERR719732_2.fastq ./fastq/ERR719733_2.fastq ./fastq/ERR719734_2.fastq ./fastq/ERR719735_2.fastq ./fastq/ERR719736_2.fastq ./fastq/ERR719737_2.fastq ./fastq/ERR719738_2.fastq ./fastq/ERR719739_2.fastq ./fastq/ERR719740_2.fastq > merged/P20_E90_2.fastq

























