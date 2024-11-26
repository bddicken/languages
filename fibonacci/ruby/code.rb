def fibonacci(n)
    fibonacci_accumulator(n, 0, 1)
end

def fibonacci_accumulator(n, a, b)
  return a if n == 0
  fibonacci_accumulator(n - 1, b, a + b)
end

u = ARGV[0].to_i
r = 0

(1...u).each do |i|
    r += fibonacci(i)
end

puts r
