#!/usr/bin/env julia
# run.jl

include("loops.jl")
include("../../lib/julia/benchmark.jl")
using .Loops
using .Benchmark

function main()
    if length(ARGS) < 3
        println("Usage: julia run.jl <run-ms> <warmup-ms> <input>")
        exit(1)
    end

    run_ms    = parse(Float64, ARGS[1])
    warmup_ms = parse(Float64, ARGS[2])
    u = parse(Int, ARGS[3])

    # Warmup run
    Benchmark.run(() -> Loops.loops(u), warmup_ms)

    # Benchmark run
    results = Benchmark.run(() -> Loops.loops(u), run_ms)

    println(Benchmark.format_results(results))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end