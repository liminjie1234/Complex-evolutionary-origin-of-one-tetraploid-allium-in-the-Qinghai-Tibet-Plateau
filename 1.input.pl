use strict;
use warnings;

my $dir="/home/share/users/liminjie/program/download/orthomclSoftware-v2.0.9/my_orthomcl_dir/compliantFasta";

my @ind;
open (F,"00.reademe.txt");
while (<F>) {
    chomp;
    push @ind,$_;
}
close F;

for my $ind (@ind){
    print "/home/share/users/liminjie/program/download/orthomclSoftware-v2.0.9/bin/orthomclAdjustFasta $ind $dir/$ind.pep.clean.fa 1\n";
}
