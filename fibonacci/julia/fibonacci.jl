module Fibonacci

export fibonacci

# base case 1
fibonacci(::Val{0}) = 0
# base case 2
fibonacci(::Val{1}) = 1
# general case
fibonacci(::Val{n}) where n = fibonacci(Val(n-1)) + fibonacci(Val(n-2))

fibonacci(n::Int) = fibonacci(Val(n))

end # module Fibonacci