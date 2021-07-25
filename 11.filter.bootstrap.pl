#!/usr/bin/perl -w

#用于提取每个文件夹下符合要求的树文件
#路径要绝对路径
#使用文件besttree

use strict;
use File::Basename;

my $raxmldir=shift;	#放置codeml结果的文件夹的总文件夹
#my @eachraxmldir=<$raxmldir/*>; #总共N个结果文件夹
my @eachraxmldir=<$raxmldir/RAxML_bipartitions.*>;
my $output=shift; #输出文件名
my $bootstrap=shift;#控制的阈值
open(H,">$output") || die "$!";
#my %tree;
my $sign=0;
foreach my $eachraxmldir (@eachraxmldir){
	chomp $eachraxmldir;
	$sign++;
	#print $eachraxmldir;
	#my $file=basename $eachraxmldir;	#取文件名
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
