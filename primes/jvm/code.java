import java.util.ArrayList;
import java.util.List;

public class code {

    public static List<Long> calcPrimes(long limit) {
        long candidate = 1;           // The current number being tested for primality
        long nextSquare = 4;          // The square of the next prime in the list, starting with 2^2
        int numPrimes = 1;            // Number of primes currently in the list
        List<Long> primes = new ArrayList<>();  // List of found primes
        primes.add(2L);               // Initialize the list with the first prime, 2
        List<Long> composites = new ArrayList<>(); // List of multiples of found primes for sieving
        composites.add(0L);           // Dummy value to align indices

        while (candidate < limit) {
            while (true) {
                candidate += 2; // Only test odd numbers for primality
                if (candidate >= limit) {
                    return primes;
                }

                // Update the list of composite values if we’ve reached the next prime square
                if (nextSquare <= candidate) {
                    composites.add(nextSquare);
                    numPrimes++;
                    nextSquare = primes.get(numPrimes - 1) * primes.get(numPrimes - 1);
                }

                int index = 1;
                boolean isPrime = true;

                // Check if candidate is a prime by verifying it is not a multiple of any smaller primes
                while (isPrime && index < numPrimes) {
                    if (composites.get(index) < candidate) {
                        composites.set(index, composites.get(index) + primes.get(index - 1));
                    }
                    isPrime = candidate != composites.get(index);
                    index++;
                }

                // Exit loop if candidate was determined to be a prime
                if (isPrime) {
                    break;
                }
            }

            // Add candidate to the list of primes
            primes.add(candidate);
        }

        return primes;
    }

    public static void main(String[] args) {
        long limit = Long.parseLong(args[0]) * 100000L;
        List<Long> primes = calcPrimes(limit);
        System.out.println("Number of primes less than " + limit + ": " + primes.size());
    }
}
