#!/usr/bin/env perl
use strict;
use warnings;
use v5.10;

# Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
# Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
# Time Complexity: O(m*n) where m and n are the lengths of the input strings
sub levenshtein_distance {
    my ($s1, $s2) = @_;
    
    # Early termination checks
    return 0 if $s1 eq $s2;
    return length($s2) if length($s1) == 0;
    return length($s1) if length($s2) == 0;

    # Make s1 the shorter string for space optimization
    if (length($s1) > length($s2)) {
        ($s1, $s2) = ($s2, $s1);
    }

    my $m = length($s1);
    my $n = length($s2);

    # Use two arrays instead of full matrix for space optimization
    my @prev_row = (0..$m);
    my @curr_row = (0) x ($m + 1);

    # Convert strings to arrays for faster access
    my @s1_chars = split //, $s1;
    my @s2_chars = split //, $s2;

    # Main computation loop
    for my $j (1..$n) {
        $curr_row[0] = $j;

        for my $i (1..$m) {
            my $cost = $s1_chars[$i-1] eq $s2_chars[$j-1] ? 0 : 1;
            
            # Calculate minimum of three operations
            $curr_row[$i] = min(
                $prev_row[$i] + 1,      # deletion
                $curr_row[$i-1] + 1,    # insertion
                $prev_row[$i-1] + cost  # substitution
            );
        }

        # Swap rows
        @prev_row = @curr_row;
    }

    return $prev_row[$m];
}

# Helper function to find minimum of three numbers
sub min {
    my ($a, $b, $c) = @_;
    return $a < $b ? ($a < $c ? $a : $c) : ($b < $c ? $b : $c);
}

# Main program
if (@ARGV < 2) {
    say "Please provide at least two strings as arguments.";
    exit 1;
}

my $min_distance = -1;
my $times = 0;

# Compare all pairs of strings
for my $i (0..$#ARGV) {
    for my $j (0..$#ARGV) {
        next if $i == $j;
        my $distance = levenshtein_distance($ARGV[$i], $ARGV[$j]);
        $min_distance = $distance if $min_distance == -1 || $distance < $min_distance;
        $times++;
    }
}

say "times: $times";
say "min_distance: $min_distance";
