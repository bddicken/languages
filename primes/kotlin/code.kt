import java.math.BigInteger

fun prime(maxPrimes: Long): BigInteger {
    // Variable declarations
    var x = BigInteger.ONE // Current candidate number
    var square = BigInteger("4") // First square (2^2)
    var lim = 1
    val primes = mutableListOf(BigInteger.TWO) // List of found primes
    val multiples = mutableListOf<BigInteger>() // List of multiples of primes
    var count = BigInteger.ONE

    for (i in 2..maxPrimes) {
        do {
            x = x.add(BigInteger.TWO) // Increment candidate by 2 (odd numbers only)

            if (x >= BigInteger.valueOf(maxPrimes)){
                return count
            }

            // Check and update square and multiples
            if (square <= x) {
                multiples.add(square)
                lim += 1
                square = primes[lim - 1].pow(2)
            }

            var k = 0
            var isPrime = true

            // Check if `x` is divisible by any of the current primes
            while (isPrime && k < lim - 1) {
                if (multiples[k] < x) {
                    multiples[k] = multiples[k].add(primes[k])
                }
                isPrime = x != multiples[k]
                k++
            }
        } while (!isPrime)

        primes.add(x)
        count = count.add(BigInteger.ONE)
    }

    return count
}

fun main(args: Array<String>) {
    val n = args.get(0).toLong() * 100000
    val c = prime(n)
    println("Number of primes: $c")
}
