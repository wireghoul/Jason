#!/usr/bin/perl
# Sort passwords into new files based on length
# Input: password file
# Output 1.txt, 2.txt, 3.txt, 4.txt, etc

use warnings;
use strict;
my @lines;

# Read from stdn in if filename is -, otherwise open file
if (! $ARGV[0]) {
    print "Usage: $0 <filename or - for STDIN>\n";
    exit 2;
}

if ("$ARGV[0]" eq "-") {
    @lines = <STDIN>;
} elsif ( -e $ARGV[0] ) {
    open my $ifh, '<', $ARGV[0] or die "Unable to open file $ARGV[0]: $!\n";
    @lines = <$ifh>;
    close $ifh;
} else {
    print "Unable to open file: $ARGV[0]\n";
    exit 2;
}

chomp @lines;
my %fhs; # Hash of filehandles, 1.txt, 2.txt, etc

print "Sorting ".scalar(@lines)." passwords by length\n";
foreach my $pw (@lines) {
    if (!defined($fhs{length($pw)})) {
        open $fhs{length($pw)}, '>', "".length($pw).".txt";
    }
    print { $fhs{length($pw)} } "$pw\n";
}
foreach my $key (keys(%fhs)) {
  print "Finished $key.txt\n";
  close $fhs{$key};
}
