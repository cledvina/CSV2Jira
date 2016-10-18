#! /usr/bin/env perl
open IN, shift or die "Can't find input csv file!\n\nUsage: ./csv2jira.pl filename [header lines]\n";
my $hl = shift || 0;
my $i = 0;
while (<IN>) {
	chomp;
	s/\\"/%%quote%%/g;
	s/"(.+?)"/comma($1)/ge;
	if ($i < $hl) {
		s/,/||/g;
		s/^|$/||/g;
	}
	else {
		s/,/|/g;
		s/^|$/|/g;
	}
	s/%%quote%%/"/g;
	s/%%comma%%/,/g;
	print "$_\n";
	$i++;
}
sub comma {
	my $m = shift; 
	$m =~ s/,/%%comma%%/g;
	return $m;
}
