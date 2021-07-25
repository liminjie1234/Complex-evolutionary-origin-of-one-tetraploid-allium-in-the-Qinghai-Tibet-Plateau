echo 'mysql -u root < mysql.setting.template'
1.mysql -u root < mysql.setting.template

### mysql配置
#mysql -u root
#drop database orthomclwzf;
create database orthomclmajch;
grant all privileges on orthomcllmj.* to liminjie@localhost identified by '1234';
flush privileges;

echo 'orthomclFilterFasta compliantFasta/ 10 20'
2.orthomclFilterFasta compliantFasta/ 10 20

echo 'makeblastdb -in goodProteins.fasta -dbtype prot' #创建名为goodProteins.fasta的blast数据库；
3.makeblastdb -in goodProteins.fasta -dbtype prot 
echo 'blastp -db goodProteins.fasta -query goodProteins.fasta -out all-all.blastp.out -evalue 1e-5 -outfmt 6 -num_threads 24' #goodProteins.fasta自身进行blast,找出目标物种间的同源基因；
4.blastp -db goodProteins.fasta -query goodProteins.fasta -out all-all.blastp.out -evalue 1e-5 -outfmt 6 -num_threads 24

echo 'orthomclInstallSchema orthomcl.config.template'#在此之前首先根据mysql.sh在mysql数据库建立orthomcllmj,然后再在这里 mysql数据库中创建表按照orthomcl.config的配置；
5.orthomclInstallSchema orthomcl.config
echo 'orthomclBlastParser all-all.blastp.out compliantFasta > similarSequences.txt'
6.orthomclBlastParser all-all.blastp.out compliantFasta > similarSequences.txt
echo 'perl -p -i -e 's/0\t0/1\t-181/' similarSequences.txt'
7.perl -p -i -e 's/0\t0/1\t-181/' similarSequences.txt
echo 'orthomclLoadBlast orthomcl.config.template similarSequences.txt' #将similarSequences.txt文件中的相似序列载入mysql数据库中；
8.orthomclLoadBlast orthomcl.config.template similarSequences.txt
echo 'orthomclPairs orthomcl.config.template orthomcl_pairs.log cleanup=no'#寻找承兑蛋白；对数据库中的空数据表进行操作；
9.orthomclPairs orthomcl.config.template orthomcl_pairs.log cleanup=no
echo 'orthomclDumpPairsFiles orthomcl.config.template'#将数据从mysql数据库中导出，这个命令的结果会在my_orthomcl_dir下生成一个mclInput文件和pairs文件夹，pairs文件夹下包含coorthologs.txt和inparalogs.txt三个文件；
orthomclDumpPairsFiles orthomcl.config.template
echo 'mcl mclInput --abc -I 1.5 -o mclOutput' #用mcl对pairs进行聚类；
10.mcl mclInput --abc -I 1.5 -o mclOutput
echo 'orthomclMclToGroups cluster 1 < mclOutput > groups.txt' #提取mcl结果，生成group.txt文件；完成；
11.orthomclMclToGroups cluster 1 < mclOutput > groups.txt
