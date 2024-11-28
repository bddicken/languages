fn calc_primes(limit: u64) -> Vec<u64> {
    let mut candidate = 1; // The current number being tested for primality
    let mut next_square = 4; // The square of the next prime in the list, starting with 2^2
    let mut num_primes = 1; // Number of primes currently in the list
    let mut primes = vec![2]; // List of found primes, starting with the first prime, 2
    let mut composites = vec![0]; // List of multiples of found primes for sieving, initialized with a dummy value

    while candidate < limit {
        loop {
            candidate += 2; // Only test odd numbers for primality
            if candidate >= limit {
                return primes;
            }

            // Update the list of composite values if we’ve reached the next prime square
            if next_square <= candidate {
                composites.push(next_square);
                num_primes += 1;
                next_square = primes[num_primes - 1] * primes[num_primes - 1];
            }

            let mut index = 1;
            let mut is_prime = true;

            // Check if candidate is a prime by verifying it is not a multiple of any smaller primes
            while is_prime && index < num_primes {
                if composites[index] < candidate {
                    composites[index] += primes[index - 1]; // Move to the next multiple for the prime
                }
                is_prime = candidate != composites[index];
                index += 1;
            }

            // Exit loop if candidate was determined to be a prime
            if is_prime {
                break;
            }
        }

        // Add candidate to the list of primes
        primes.push(candidate);
    }

    primes
}

fn main() {
    let limit: u64 = std::env::args().nth(1).unwrap().parse::<u64>().unwrap() * 100000;
    let primes = calc_primes(limit);
    println!("Number of primes less than {}: {}", limit, primes.len());
}
