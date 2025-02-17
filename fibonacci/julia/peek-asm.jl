#!/usr/bin/env julia
# peek-asm.jl

using InteractiveUtils

include("fibonacci.jl")
include("fibonacci-no-val.jl")
include("../../lib/julia/benchmark.jl")
using .Fibonacci
using .FibonacciNoVal
using .Benchmark

function main()
    if length(ARGS) < 1
        println("Usage: julia peek-asm.jl <n>")
        exit(1)
    end

    n = parse(Int, ARGS[1])

    # Warmup run
    Benchmark.run(() -> Fibonacci.fibonacci(n), 100)
    Benchmark.run(() -> FibonacciNoVal.fibonacci(n), 100)

    println("Val version: ASM")
    @code_native Fibonacci.fibonacci(Val(n))

    println("\n-----\n")
    println("NoVal version: ASM")
    @code_native FibonacciNoVal.fibonacci(n)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
