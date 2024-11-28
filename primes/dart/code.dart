List<int> calcPrimes(int limit) {
  int candidate = 1;
  int nextSquare = 4;
  int numPrimes = 1;
  List<int> primes = [2];
  List<int> composites = [0];

  while (candidate < limit) {
    while (true) {
      candidate += 2;
      if (candidate >= limit) {
        return primes;
      }
      if (nextSquare <= candidate) {
        composites.add(nextSquare);
        numPrimes += 1;
        nextSquare = primes[numPrimes - 1] * primes[numPrimes - 1];
      }
      int index = 1;
      bool isPrime = true;
      while (isPrime && index < numPrimes) {
        if (composites[index] < candidate) {
          composites[index] += primes[index - 1];
        }
        isPrime = candidate != composites[index];
        index += 1;
      }
      if (isPrime) {
        break;
      }
    }
    primes.add(candidate);
  }
  return primes;
}

void main(List<String> args) {
  int limit = int.parse(args[0]) * 100000;
  List<int> primes = calcPrimes(limit);
  print('Number of primes less than $limit: ${primes.length}');
}