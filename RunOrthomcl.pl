use strict;
use warnings;

`scp old_master:/home/users/yangyongzhi2012/tool/orthomcl/orthomclSoftware-v2.0.9/doc/OrthoMCLEngine/Main/orthomcl.config.template .` if (! -e "orthomcl.config.template");
`scp old_master:/home/users/yangyongzhi2012/tool/orthomcl/orthomclSoftware-v2.0.9/doc/OrthoMCLEngine/Main/mysql.setting.template .` if (! -e "mysql.setting.template");
print "echo 'mysql -u root < mysql.setting.template'\nmysql -u root < mysql.setting.template\n\n";

print "echo 'orthomclFilterFasta compliantFasta/ 10 20'\northomclFilterFasta compliantFasta/ 10 20\n\n";

print "echo 'makeblastdb -in goodProteins.fasta -dbtype prot'\nmakeblastdb -in goodProteins.fasta -dbtype prot\n";
print "echo 'blastp -db goodProteins.fasta -query goodProteins.fasta -out all-all.blastp.out -evalue 1e-5 -outfmt 6 -num_threads 24'\nblastp -db goodProteins.fasta -query goodProteins.fasta -out all-all.blastp.out -evalue 1e-5 -outfmt 6 -num_threads 24\n\n";

print "echo 'orthomclInstallSchema orthomcl.config.template'\northomclInstallSchema orthomcl.config.template\n";
print "echo 'orthomclBlastParser all-all.blastp.out compliantFasta > similarSequences.txt'\northomclBlastParser all-all.blastp.out compliantFasta > similarSequences.txt\n";
print "echo 'perl -p -i -e 's/0\\t0/1\\t-181/' similarSequences.txt'\nperl -p -i -e 's/0\\t0/1\\t-181/' similarSequences.txt\n";
print "echo 'orthomclLoadBlast orthomcl.config.template similarSequences.txt'\northomclLoadBlast orthomcl.config.template similarSequences.txt\n";
print "echo 'orthomclPairs orthomcl.config.template orthomcl_pairs.log cleanup=no'\northomclPairs orthomcl.config.template orthomcl_pairs.log cleanup=no\n";
print "echo 'orthomclDumpPairsFiles orthomcl.config.template'\northomclDumpPairsFiles orthomcl.config.template\n";
print "echo 'mcl mclInput --abc -I 1.5 -o mclOutput'\nmcl mclInput --abc -I 1.5 -o mclOutput\n";
print "echo 'orthomclMclToGroups cluster 1 < mclOutput > groups.txt'\northomclMclToGroups cluster 1 < mclOutput > groups.txt\n";
