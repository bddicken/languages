#!/usr/bin/env perl
use strict;
use warnings;

sub fibonacci {
    my ($n) = @_;
    return 0 if $n == 0;
    return 1 if $n == 1;
    return fibonacci($n-1) + fibonacci($n-2);
}

my $u = $ARGV[0];
my $r = 0;
for my $i (1..$u-1) {
    $r += fibonacci($i);
}
print "$r\n";
