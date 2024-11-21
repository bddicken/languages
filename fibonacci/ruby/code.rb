def fibonacci(n)
    return 0 if n == 0
    return 1 if n == 1
    fibonacci(n - 1) + fibonacci(n - 2)
end

u = ARGV[0].to_i
r = 0

(1...u).each do |i|
    r += fibonacci(i)
end

puts r
