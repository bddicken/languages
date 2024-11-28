import sys
def calc_primes(limit):
    candidate = 1          # The current number being tested for primality
    next_square = 4         # The square of the next prime in the list, starting with 2^2
    num_primes = 1          # Number of primes currently in the list
    primes = [2]            # List of found primes, starting with the first prime, 2
    composites = [0]        # List of multiples of found primes for sieving, initialized with a dummy value

    while candidate < limit:
        while True:
            candidate += 2  # Only test odd numbers for primality
            if candidate >= limit:
                return primes

            # Update the list of composite values if we’ve reached the next prime square
            if next_square <= candidate:
                composites.append(next_square)
                num_primes += 1
                next_square = primes[num_primes - 1] * primes[num_primes - 1]

            index = 1
            is_prime = True

            # Check if candidate is a prime by verifying it is not a multiple of any smaller primes
            while is_prime and index < num_primes:
                if composites[index] < candidate:
                    composites[index] += primes[index - 1]  # Move to the next multiple for the prime
                is_prime = candidate != composites[index]
                index += 1

            # Exit loop if candidate was determined to be a prime
            if is_prime:
                break

        # Add candidate to the list of primes
        primes.append(candidate)

    return primes


def main():
    limit = int(sys.argv[1]) * 100000
    primes = calc_primes(limit)
    print(f"Number of primes less than {limit}: {len(primes)}")


if __name__ == "__main__":
    main()
