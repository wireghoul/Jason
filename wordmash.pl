#!/usr/bin/perl
# Mashes words together to make longer words
# Restricted by max length only?
# max 7 = batcave, catcave, mancave, batword, batboar, batwork, etc
my $wlist = $ARGV[0];
my $max = $ARGV[1];

open (my $fh, '<', $wlist) or die "Unable to open file $wlist: $!\n";
my @words = <$fh>;
close ($fh) or die "Unable to close file $wlist: $!\n";
chomp(@words);

my @fillers = grep /^.{1,$max}$/, @words;
print scalar(@fillers)."\n";
foreach $word (@words) {
    &mash($word);
}

sub mash {
    my $word = shift;
    my $spaces = $max - length($word);
    if ($spaces) {
        my @padwords = grep /^.{1,$spaces}$/, @fillers;
        foreach my $padword (@padwords) {
            print "$word$padword\n";
        }
    }
}  
