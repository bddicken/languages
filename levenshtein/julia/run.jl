#!/usr/bin/env julia
# run.jl

include("levenshtein.jl")
include("../../lib/julia/benchmark.jl")
using .Levenshtein
using .Benchmark

function main()
    if length(ARGS) < 3
        println("Usage: julia run.jl <run-ms> <warmup-ms> <file>")
        exit(1)
    end

    run_ms    = parse(Float64, ARGS[1])
    warmup_ms = parse(Float64, ARGS[2])
    file      = ARGS[3]
    strings = readlines(file)

    # Warmup run using warmup_ms
    Benchmark.run(() -> Levenshtein.distances(strings), warmup_ms)

    # Benchmark run
    results = Benchmark.run(() -> Levenshtein.distances(strings), run_ms)

    total_distance = sum(results.result)
    # Create a new results tuple with the total distance replacing the list of distances.
    new_results = merge(results, (result = total_distance,))

    println(Benchmark.format_results(new_results))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
