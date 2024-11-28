function calcPrimes(limit) {
    let candidate = 1; // The current number being tested for primality
    let nextSquare = 4; // The square of the next prime in the list, starting with 2^2
    let numPrimes = 1; // Number of primes currently in the list
    let primes = [2]; // List of found primes, starting with the first prime, 2
    let composites = [0]; // List of multiples of found primes for sieving, initialized with a dummy value

    while (candidate < limit) {
        while (true) {
            candidate += 2; // Only test odd numbers for primality
            if (candidate >= limit) {
                return primes;
            }

            // Update the list of composite values if we’ve reached the next prime square
            if (nextSquare <= candidate) {
                composites.push(nextSquare);
                numPrimes++;
                nextSquare = primes[numPrimes - 1] * primes[numPrimes - 1];
            }

            let index = 1;
            let isPrime = true;

            // Check if candidate is a prime by verifying it is not a multiple of any smaller primes
            while (isPrime && index < numPrimes) {
                if (composites[index] < candidate) {
                    composites[index] += primes[index - 1]; // Move to the next multiple for the prime
                }
                isPrime = candidate !== composites[index];
                index++;
            }

            // Exit loop if candidate was determined to be a prime
            if (isPrime) {
                break;
            }
        }

        // Add candidate to the list of primes
        primes.push(candidate);
    }

    return primes;
}

function main() {
    const limit = Number(process.argv[2]) * 100000;
    const primes = calcPrimes(limit);
    console.log(`Number of primes less than ${limit}: ${primes.length}`);
}

main();
