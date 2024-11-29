package jvm;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

public class code {

    private static BigInteger calculatePrimes(long maxPrimes) {
        // Variable declarations
        BigInteger x = BigInteger.ONE; // Current candidate number
        BigInteger square = new BigInteger("4"); // First square (2^2)
        int lim = 1;
        List<BigInteger> primes = new ArrayList<>(); // List of found primes
        primes.add(BigInteger.TWO); // Add the first prime
        List<BigInteger> multiples = new ArrayList<>(); // List of multiples of primes
        BigInteger count = BigInteger.ONE;
        boolean isPrime;

        for (long i = 2; i <= maxPrimes; i++) {
            do {
                x = x.add(BigInteger.TWO); // Increment candidate by 2 (odd numbers only)

                if (x.compareTo(BigInteger.valueOf(maxPrimes)) >= 0) {
                    return count;
                }

                // Check and update square and multiples
                if (square.compareTo(x) <= 0) {
                    multiples.add(square);
                    lim++;
                    square = primes.get(lim - 1).pow(2);
                }

                int k = 0;
                isPrime = true;

                // Check if `x` is divisible by any of the current primes
                while (isPrime && k < lim - 1) {
                    if (multiples.get(k).compareTo(x) < 0) {
                        multiples.set(k, multiples.get(k).add(primes.get(k)));
                    }
                    isPrime = !x.equals(multiples.get(k));
                    k++;
                }
            } while (!isPrime);

            primes.add(x);
            count = count.add(BigInteger.ONE);
        }

        return count;
    }

    public static void main(String[] args) {
        long n = Long.parseLong(args[0]) * 100000;
        BigInteger c = calculatePrimes(n);
        System.out.println("Num of primes: " + c);
    }
}
