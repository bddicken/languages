<?php

function calcPrimes($limit)
{
    $candidate = 1;         // The current number being tested for primality
    $nextSquare = 4;        // The square of the next prime in the list, starting with 2^2
    $numPrimes = 1;         // Number of primes currently in the list
    $primes = [2];          // List of found primes, starting with the first prime, 2
    $composites = [0];      // List of multiples of found primes for sieving, initialized with a dummy value

    while ($candidate < $limit) {
        while (true) {
            $candidate += 2; // Only test odd numbers for primality
            if ($candidate >= $limit) {
                return $primes;
            }

            // Update the list of composite values if we’ve reached the next prime square
            if ($nextSquare <= $candidate) {
                $composites[] = $nextSquare;
                $numPrimes++;
                $nextSquare = $primes[$numPrimes - 1] * $primes[$numPrimes - 1];
            }

            $index = 1;
            $isPrime = true;

            // Check if candidate is a prime by verifying it is not a multiple of any smaller primes
            while ($isPrime && $index < $numPrimes) {
                if ($composites[$index] < $candidate) {
                    $composites[$index] += $primes[$index - 1]; // Move to the next multiple for the prime
                }
                $isPrime = $candidate != $composites[$index];
                $index++;
            }

            // Exit loop if candidate was determined to be a prime
            if ($isPrime) {
                break;
            }
        }

        // Add candidate to the list of primes
        $primes[] = $candidate;
    }

    return $primes;
}

function main($limit)
{
    $primes = calcPrimes($limit);
    echo "Number of primes less than $limit: " . count($primes) . "\n";
}

$limit = (int) $argv[1] * 100000;
main($limit);
