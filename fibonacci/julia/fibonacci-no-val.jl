module FibonacciNoVal

export fibonacci

function fibonacci(n::Int)::Int
    if n < 2
        return n
    else
        return fibonacci(n - 1) + fibonacci(n - 2)
    end
end

end # module FibonacciNoVal