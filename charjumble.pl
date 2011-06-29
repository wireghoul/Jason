#!/usr/bin/perl
# Will shuffle through all possible letter combinations.
# Ie: steak becomes kstea, kseat, teaks, seatk, atsek, etc

use strict;
use warnings;

my @lines;
our $password;

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
foreach $password (@lines) {
    &munge('', split //, $password);
}

# Recursive iterator function
sub munge {
    my ($word, @chars) = @_;
    my @previous;
    if (! scalar(@chars) ) {
        print "$word\n";
        return;
    }
    # Shifting the first cell in array to avoid splice causing an off by one bug
    my $nword = $word.$chars[0];
    @previous = splice(@chars,0,1);
    &munge ($nword, @chars);
    for (my $i=0;$i<scalar(@chars);$i++) {
        my $nword = $word.$chars[$i];
	@previous = splice(@chars,$i,1, @previous);
    	&munge ($nword, @chars);
    }
}
