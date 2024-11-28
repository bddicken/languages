def calc_primes(limit)
  candidate = 1
  next_square = 4
  num_primes = 1
  primes = [2]
  composites = [0]
  while candidate < limit
    loop do
      candidate += 2
      if candidate >= limit
        return primes
      end
      if next_square <= candidate
        composites.push(next_square)
        num_primes += 1
        next_square = primes[num_primes-1] * primes[num_primes-1]
      end
      index = 1
      is_prime = true
      while is_prime && index < num_primes
        if composites[index] < candidate
          composites[index] += primes[index-1]
        end
        is_prime = candidate != composites[index]
        index += 1
      end
      if is_prime
        break
      end
    end
    primes.push(candidate)
  end
  primes
end

limit = ARGV[0].to_i * 100000
primes = calc_primes(limit)
puts "Number of primes less than #{limit}: #{primes.length}"