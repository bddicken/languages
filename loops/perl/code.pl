use strict;
use warnings;

my $u = int($ARGV[0]);                           # Get an input number from the command line
my $r = int(rand(10000));                        # Get a random number 0 <= r < 10k
my @a = (0) x 10000;                             # Array of 10k elements initialized to 0

for my $i (0 .. 9999) {                          # 10k outer loop iterations
    for my $j (0 .. 99999) {                     # 100k inner loop iterations, per outer loop iteration
        $a[$i] += $j % $u;                       # Simple sum
    }
    $a[$i] += $r;                                # Add a random value to each element in array
}

print $a[$r], "\n";                              # Print out a single element from the array
