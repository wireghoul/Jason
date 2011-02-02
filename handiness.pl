#!/usr/bin/perl
# Calculate hand usage of password by characters
# Values closer to 1 means lefthand usage, -1 means right hand.

use strict;
use warnings;

# Key distribution might need tweaking
my $l_hand = '`12345qwertasdfgzxcvb~!@#$%QWERTASDFGZXCVB';
my $r_hand = qq!67890-=yuiop[]\\hjkl;'nm,./^&*()_+YUIOP{}|HJKL:"NM<>?!;

my @lines;

# If arg is file read file, if ard is '-' read stdin, otherwise treat arg as password to test
print "Handiness! Calculates hand use in passwords. 1 is 100% left hand -1 is right hand\n";
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
    my @pwchars = split //, $password;
    my $l_count = 0;
    my $r_count = 0;
    foreach my $char (@pwchars) {
        # Need to use instring search function to handle regex metachars
        if ($l_hand =~ /$char/) {
            $l_count++;
        } elsif ($r_hand =~ /$char/) {
            $r_count++;
        }
    }
    my $total = length($password);
    print $l_count/$total - $r_count/$total."\t$password\n";
}
