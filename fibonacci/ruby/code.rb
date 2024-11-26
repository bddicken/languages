require 'matrix'

def fib(u) = (Matrix[[0, 1], [1, 1]]**u)[1, 1].pred

u = Integer ARGV.shift
r = fib u

puts r
