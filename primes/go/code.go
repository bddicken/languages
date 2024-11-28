package main

import (
	"fmt"
  "strconv"
  "os"
)

func calcPrimes(limit uint64) []uint64 {
	candidate := uint64(1)        // The current number being tested for primality
	nextSquare := uint64(4)      // The square of the next prime in the list, starting with 2^2
	numPrimes := 1               // Number of primes currently in the list
	primes := []uint64{2}        // List of found primes, starting with the first prime, 2
	composites := []uint64{0}    // List of multiples of found primes for sieving, initialized with a dummy value

	for candidate < limit {
		for {
			candidate += 2 // Only test odd numbers for primality
			if candidate >= limit {
				return primes
			}

			// Update the list of composite values if we’ve reached the next prime square
			if nextSquare <= candidate {
				composites = append(composites, nextSquare)
				numPrimes++
				nextSquare = primes[numPrimes-1] * primes[numPrimes-1]
			}

			index := 1
			isPrime := true

			// Check if candidate is a prime by verifying it is not a multiple of any smaller primes
			for isPrime && index < numPrimes {
				if composites[index] < candidate {
					composites[index] += primes[index-1] // Move to the next multiple for the prime
				}
				isPrime = candidate != composites[index]
				index++
			}

			// Exit loop if candidate was determined to be a prime
			if isPrime {
				break
			}
		}

		// Add candidate to the list of primes
		primes = append(primes, candidate)
	}

	return primes
}

func main() {
	limit, e := strconv.Atoi(os.Args[1])
  if e != nil { panic(e) }
	primes := calcPrimes(uint64(limit) * 100000)
	fmt.Printf("Number of primes less than %d: %d\n", limit, len(primes))
}
