#! usr/bin/perl -w

use strict;
use warnings;

my $doc=shift;
my @name=split(/\./, $doc);
open (O1, ">$name[0].Ks.txt") || die;
print O1 "Ks\tspecies\n";

chdir("$doc");
my @file=<*.homo/yn.out>;

foreach my $file(@file)
{
    open (I1, "<$file") || die;
    my $Ks=0;
    while (<I1>)
    {
	chomp;
	if (/^LWL85:  dS =  (\w+\.\w+)/ || /^LWL85m: dS =  (\w+\.\w+)/ ||/^LPB93:  dS =  (\w+\.\w+)/)
	{
	    $Ks=$Ks+$1;
	}
    }
    my $ks=$Ks/3;
    my @tem=split(/_/, $name[0]);
    my $name=$tem[2];
    print O1 "$ks\t$name\n";
}

close I1;
close O1;
