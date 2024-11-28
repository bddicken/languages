#include <stdio.h>
#include <stdlib.h>

long* calc_primes(long limit, int* primes_count) {
    long candidate = 1;         // The current number being tested for primality
    long next_square = 4;       // The square of the next prime in the list, starting with 2^2
    int num_primes = 1;         // Number of primes currently in the list
    long* primes = (long*)malloc(sizeof(long) * 100);  // Allocate memory for primes
    primes[0] = 2;              // List of found primes, starting with the first prime, 2
    long* composites = (long*)malloc(sizeof(long) * 100); // Allocate memory for composites
    composites[0] = 0;          // List of multiples of found primes for sieving, initialized with a dummy value

    while (candidate < limit) {
        while (1) {
            candidate += 2; // Only test odd numbers for primality
            if (candidate >= limit) {
                *primes_count = num_primes;
                return primes;
            }

            // Update the list of composite values if we’ve reached the next prime square
            if (next_square <= candidate) {
                composites[num_primes] = next_square;
                num_primes++;
                next_square = primes[num_primes - 1] * primes[num_primes - 1];
            }

            int index = 1;
            int is_prime = 1;

            // Check if candidate is a prime by verifying it is not a multiple of any smaller primes
            while (is_prime && index < num_primes) {
                if (composites[index] < candidate) {
                    composites[index] += primes[index - 1]; // Move to the next multiple for the prime
                }
                is_prime = (candidate != composites[index]);
                index++;
            }

            // Exit loop if candidate was determined to be a prime
            if (is_prime) {
                break;
            }
        }

        // Add candidate to the list of primes
        primes[num_primes] = candidate;
        num_primes++;
    }

    *primes_count = num_primes;
    return primes;
}

int main(int argc, char **argv) {
    long limit = atoi(argv[1]) * 100000;
    int primes_count = 0;
    long* primes = calc_primes(limit, &primes_count);

    printf("Number of primes less than %ld: %d\n", limit, primes_count);

    // Free the dynamically allocated memory
    free(primes);
    return 0;
}
