#!/usr/bin/env julia
# run.jl

include("fibonacci.jl")
include("../../lib/julia/benchmark.jl")
using .Fibonacci
using .Benchmark

function main()
    if length(ARGS) < 3
        println("Usage: julia run.jl <run-ms> <warmup-ms> <n>")
        exit(1)
    end

    run_ms    = parse(Float64, ARGS[1])
    warmup_ms = parse(Float64, ARGS[2])
    n = parse(Int, ARGS[3])

    # Warmup run
    Benchmark.run(() -> Fibonacci.fibonacci(n), warmup_ms)

    # Benchmark run
    results = Benchmark.run(() -> Fibonacci.fibonacci(n), run_ms)

    println(Benchmark.format_results(results))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end