#! usr/bin/perl -w

use strict;
use warnings;
use File::Basename;

my $test=shift;
my $doc=shift;

open (I1, "<$test") || die;
my @file;
while (<I1>)
{
    chomp;
    push @file, $_;
}

chdir ("$doc");
open (O1, ">05.get-run_paml.sh") || die;

foreach my $file(@file)
{
    my @name=split(/\./, $file);
    my $name=join('.',$name[0],$name[1]);
    #my $name=basename $file;
    `mkdir $name.homo`;
    print O1 "cp $file $name.homo/gene.paml\n";
    print O1 "cp ../yn00.ctl $name.homo/yn00.ctl\n";
    print O1 " cd $name.homo; /home/share/users/liminjie/program/download/PAML/paml4.8/bin/yn00 yn00.ctl; cd ..;\n";
}

close I1;
close O1;
