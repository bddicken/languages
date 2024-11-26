#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
my $u;
if(@ARGV) {
	$u = int(shift(@ARGV));
} else {
	die "Please input an integer\n";
}

sub factorial {
	my ($n, $total) = @_;

	$total ||= 1;

	return $total if ($n == 0);
	@_ = ($n - 1, $n * $total);
	goto &factorial;
}

say factorial($u);

