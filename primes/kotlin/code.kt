fun calcPrimes(limit: Long): List<Long> {
    var candidate = 1L         // The current number being tested for primality
    var nextSquare = 4L        // The square of the next prime in the list, starting with 2^2
    var numPrimes = 1          // Number of primes currently in the list
    val primes = mutableListOf(2L)  // List of found primes, starting with the first prime, 2
    val composites = mutableListOf(0L) // List of multiples of found primes for sieving, initialized with a dummy value

    while (candidate < limit) {
        while (true) {
            candidate += 2 // Only test odd numbers for primality
            if (candidate >= limit) {
                return primes
            }

            // Update the list of composite values if we’ve reached the next prime square
            if (nextSquare <= candidate) {
                composites.add(nextSquare)
                numPrimes++
                nextSquare = primes[numPrimes - 1] * primes[numPrimes - 1]
            }

            var index = 1
            var isPrime = true

            // Check if candidate is a prime by verifying it is not a multiple of any smaller primes
            while (isPrime && index < numPrimes) {
                if (composites[index] < candidate) {
                    composites[index] += primes[index - 1] // Move to the next multiple for the prime
                }
                isPrime = candidate != composites[index]
                index++
            }

            // Exit loop if candidate was determined to be a prime
            if (isPrime) {
                break
            }
        }

        // Add candidate to the list of primes
        primes.add(candidate)
    }

    return primes
}

fun main(args: Array<String>) {
    val limit = args.get(0).toInt() * 100000L
    val primes = calcPrimes(limit)
    println("Number of primes less than $limit: ${primes.size}")
}
