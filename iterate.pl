#!/usr/bin/perl
# Iterates numbers or meta characters in passwords
# Ie password1 becomes password2, password3, etc

use strict;
use warnings;

# Replacement map
my %char;
$char{'0'} = [ '1','2','3','4','5','6','7','8','9' ];
$char{'1'} = [ '0','2','3','4','5','6','7','8','9' ];
$char{'2'} = [ '0','1','3','4','5','6','7','8','9' ];
$char{'3'} = [ '0','1','2','4','5','6','7','8','9' ];
$char{'4'} = [ '0','1','2','3','5','6','7','8','9' ];
$char{'5'} = [ '0','1','2','3','4','6','7','8','9' ];
$char{'6'} = [ '0','1','2','3','4','5','7','8','9' ];
$char{'7'} = [ '0','1','2','3','4','5','6','8','9' ];
$char{'8'} = [ '0','1','2','3','4','5','6','7','9' ];
$char{'9'} = [ '0','1','2','3','4','5','6','7','8' ];

if (! $ARGV[0]) {
    print "Usage $0 <password>\n";
    exit 2;
}

print "$ARGV[0]\n";
&munge($ARGV[0],0);

# Recursive iterator function
sub munge {
    my ($word, $index) = @_;
    my @pwchar = split //, $word;
    if ($index >= length($word)) {
        return;
    }
    if (exists($char{$pwchar[$index]})) {
        foreach my $chm (@{ $char{$pwchar[$index]} }) {
           print substr($word,0,$index).$chm.substr($word,$index+1, length($word))."\n";
           &munge (substr($word,0,$index).$chm.substr($word,$index+1, length($word)), $index+1);
        }
        &munge($word,$index+1);
    } else {
        &munge($word,$index+1);
    }
}
