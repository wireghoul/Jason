#!/usr/bin/perl
# Shuffles upper/lower case 
# Ie: password becomes Password, pAssword .. PASSWORD

use strict;
use warnings;
my @lines;

if (! $ARGV[0]) {
    print "Usage $0 <password, - or filename>\n";
} elsif ($ARGV[0] eq '-') {
    @lines = <STDIN>;
} elsif ( -e $ARGV[0] ) {
    open my $ifh, '<', $ARGV[0];
    @lines = <$ifh>;
    close $ifh;
} else {
    push @lines, $ARGV[0];
}
chomp(@lines);
foreach my $password (@lines) {
    print "$password\n";
    &munge($password,0);
}

# Recursive iterator function
sub munge {
    my ($word, $index) = @_;
    my @pwchar = split //, $word;
    if ($index >= length($word)) {
        return;
    }
	if ($pwchar[$index] =~ /[a-z]/i) {
		if ($pwchar[$index] eq lc($pwchar[$index])) {
		    &munge (substr($word,0,$index).$pwchar[$index].substr($word,$index+1, length($word)), $index+1);
			$pwchar[$index] = uc($pwchar[$index]);
			print substr($word,0,$index).$pwchar[$index].substr($word,$index+1, length($word))."\n";
			&munge (substr($word,0,$index).$pwchar[$index].substr($word,$index+1, length($word)), $index+1);
		} else {
			$pwchar[$index] = lc($pwchar[$index]);
			print substr($word,0,$index).$pwchar[$index].substr($word,$index+1, length($word))."\n";
			&munge (substr($word,0,$index).$pwchar[$index].substr($word,$index+1, length($word)), $index+1);
			$pwchar[$index] = uc($pwchar[$index]);
			&munge (substr($word,0,$index).$pwchar[$index].substr($word,$index+1, length($word)), $index+1);
		}
	} else {
		&munge($word,$index+1);
	}
}
