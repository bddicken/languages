#!/usr/bin/perl
my $n;
if(@ARGV) {
	$n = int(shift @ARGV);
} else {
	die "Please input an integer\n";
}

my $r = int(rand(10000));
my @a; #let perl allocate the array
my $i;
my $j;
for $i (0..10000) {
	for $j (0..100000) {
		$a[$i] = $a[$i] + $j%$n;
	}
	$a[$i] += $r;
}

print "$a[$r]\n";

