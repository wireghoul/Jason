#!/usr/bin/perl
# Will mangle characters in password with numbers and special characters
# Ie: steak becomes st3ak, st34k, ste@k, s7eak, s734k,5t3ak, etc

use strict;
use warnings;

my @lines;
# Replacement map
my %char;
$char{'a'} = [ 'A',"\@",'4' ];
$char{'b'} = [ 'B','8' ];
$char{'e'} = [ 'E','3' ];
$char{'g'} = [ 'G','9' ];
$char{'i'} = [ 'I','1',"\!","\|" ];
$char{'l'} = [ 'L' ,'1','7',"\!","\|" ];
$char{'o'} = [ 'O','0','*' ];
$char{'s'} = [ 'S','5',"\$" ];
$char{'t'} = [ 'T','7' ];

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
    if (exists($char{$pwchar[$index]})) {
        # print "Munging $pwchar[$index] in $word with ".join('|', @{ $char{$pwchar[$index]} })."\n"; 
        foreach my $chm (@{ $char{$pwchar[$index]} }) {
           print substr($word,0,$index).$chm.substr($word,$index+1, length($word))."\n";
           &munge (substr($word,0,$index).$chm.substr($word,$index+1, length($word)), $index+1);
        }
        &munge($word,$index+1);
    } else {
        &munge($word,$index+1);
    }
}
