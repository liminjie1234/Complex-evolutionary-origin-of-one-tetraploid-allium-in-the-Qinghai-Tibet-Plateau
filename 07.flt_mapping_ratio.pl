#! usr/bin/perl -w

use strict;
use warnings;
use Bio::SeqIO;

my $doc=shift;
open(O1, ">$doc.ratio.txt") || die;
chdir ("$doc");
my @fasta=<*.best.fas>;
foreach my $file(@fasta)
{
    my %gap;
    my $all=Bio::SeqIO->new(-file=>$file,-format=>'fasta');
    my $length;
    while(my $seq=$all->next_seq)
    {
	my $id=$seq->id;
	my $seq=$seq->seq;

	my @seq=split(//, $seq);
	$length=@seq;
	my $i=0;
	foreach my $j(@seq)   
	{
	    if ($j=~/-/)	
	    {
		$gap{$i}++;
	    }
	    $i++;
	}
    }

    my $aln=0;
    foreach my $k(sort keys %gap)
    {
	$aln++;
    }
    my $ratio=100-$aln/$length*100;
    my $l=$length-$aln;
    if ($ratio>50 && $length>300)
    {
	print O1 "$file\n";
    }
}
