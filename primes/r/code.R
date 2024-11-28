calc_primes <- function(limit) {
  candidate <- 1           # The current number being tested for primality
  next_square <- 4         # The square of the next prime in the list, starting with 2^2
  num_primes <- 1          # Number of primes currently in the list
  primes <- c(2)           # List of found primes, starting with the first prime, 2
  composites <- c(0)       # List of multiples of found primes for sieving, initialized with a dummy value

  while (candidate < limit) {
    repeat {
      candidate <- candidate + 2  # Only test odd numbers for primality
      if (candidate >= limit) {
        return(primes)
      }

      # Update the list of composite values if we’ve reached the next prime square
      if (next_square <= candidate) {
        composites <- c(composites, next_square)
        num_primes <- num_primes + 1
        next_square <- primes[num_primes] * primes[num_primes]
      }

      index <- 2
      is_prime <- TRUE

      # Check if candidate is a prime by verifying it is not a multiple of any smaller primes
      while (is_prime && index <= num_primes) {
        if (composites[index] < candidate) {
          composites[index] <- composites[index] + primes[index - 1]  # Move to the next multiple for the prime
        }
        is_prime <- candidate != composites[index]
        index <- index + 1
      }

      # Exit loop if candidate was determined to be a prime
      if (is_prime) {
        break
      }
    }

    # Add candidate to the list of primes
    primes <- c(primes, candidate)
  }

  return(primes)
}

main <- function() {
  args <- commandArgs(trailingOnly = TRUE)
  limit <- as.numeric(args[1]) * 100000
  primes <- calc_primes(limit)
  cat("Number of primes less than", limit, ":", length(primes), "\n")
}

main()
