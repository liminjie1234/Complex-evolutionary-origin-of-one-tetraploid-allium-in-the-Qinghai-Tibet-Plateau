use strict;
use warnings;

my $in_file=shift;


open (I, "<$in_file")||die $!;
open (O,">$in_file\_filter.txt")||die $!;
print O "Ks\tspecies\n";
while (<I>){
    chomp;
    next if ($_=~/^Ks/);
    my @ks=split(/\s+/,$_);
    if ($ks[0]>0){
	print O join ("\t",$ks[0],$ks[1]),"\n";
    }
}

close I;
close O;
