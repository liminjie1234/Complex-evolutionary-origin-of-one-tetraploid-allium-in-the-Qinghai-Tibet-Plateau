#!/usr/bin/perl -w

#������ȡÿ���ļ����·���Ҫ������ļ�
#·��Ҫ����·��
#ʹ���ļ�besttree

use strict;
use File::Basename;

my $raxmldir=shift;	#����codeml������ļ��е����ļ���
#my @eachraxmldir=<$raxmldir/*>; #�ܹ�N������ļ���
my @eachraxmldir=<$raxmldir/RAxML_bipartitions.*>;
my $output=shift; #����ļ���
my $bootstrap=shift;#���Ƶ���ֵ
open(H,">$output") || die "$!";
#my %tree;
my $sign=0;
foreach my $eachraxmldir (@eachraxmldir){
	chomp $eachraxmldir;
	$sign++;
	#print $eachraxmldir;
	#my $file=basename $eachraxmldir;	#ȡ�ļ���
	#if (-s "$eachraxmldir/RAxML_bipartitions.$file"){
	#print $eachraxmldir;
	#my $resultfile="$eachraxmldir/RAxML_bipartitions.$file";
	my $resultfile=$eachraxmldir;
	$eachraxmldir=~s/RAxML_bipartitions/RAxML_bestTree/;
	print $eachraxmldir;
	print "\n";
	open (I,"<$resultfile")|| die "$!";
	while(my $line=<I>){
		$line=~s/\:\d*.\d*//g;
		#my @value=($line=~m/\)[1-9]\d*/g);
		$line=~/\)([1-9]\d*)/;
		my $value=$1;
		if ($value>=$bootstrap){
			open(F,"<$eachraxmldir");
			while(my $infile=<F>) {
				print H "$resultfile\t$infile";
			}
			close F;
		}
	}
	close I;
}

close H;
print $sign;