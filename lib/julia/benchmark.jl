module Benchmark

export run, format_results

"""
    run(f, run_ms)

Runs the function `f` repeatedly until the total elapsed time exceeds `run_ms` milliseconds.
If `run_ms` is 0, `f` is run once and dummy timing stats are returned.
If `run_ms` is 1, status dots are not printed (this is assumed to be a correctness check).
Returns a NamedTuple with keys:
  - `runs`: number of iterations
  - `result`: the result from the last call to `f`
  - `mean_ms`, `min_ms`, `max_ms`, `std_dev_ms`: timing stats (in milliseconds)
"""
function run(f, run_ms::Real)
    if run_ms == 0
        return (runs = 0, result = f(), mean_ms = 0.0, min_ms = 0.0, max_ms = 0.0, std_dev_ms = 0.0)
    end
    run_ns = run_ms * 1e6  # convert milliseconds to nanoseconds
    init_t = time_ns()
    last_status_t = init_t
    if run_ms > 1
        print(stderr, ".")
        flush(stderr)
    end
    results = Int64[]
    runs = 0
    total_elapsed = 0
    result = nothing
    while total_elapsed < run_ns
        t0 = time_ns()
        result = f()
        t1 = time_ns()
        elapsed = t1 - t0
        push!(results, elapsed)
        total_elapsed += elapsed
        runs += 1
        if run_ms > 1 && (t0 - last_status_t > 1e9)  # print dot if > 1 sec has passed
            print(stderr, ".")
            flush(stderr)
            last_status_t = t0
        end
    end
    if run_ms > 1
        println(stderr)
    end
    mean_ns = total_elapsed / runs
    min_ns = minimum(results)
    max_ns = maximum(results)
    variance = sum((t - mean_ns)^2 for t in results) / runs
    std_dev_ns = sqrt(variance)
    mean_ms = mean_ns / 1e6
    min_ms = min_ns / 1e6
    max_ms = max_ns / 1e6
    std_dev_ms = std_dev_ns / 1e6
    return (runs = runs, result = result, mean_ms = mean_ms, min_ms = min_ms, max_ms = max_ms, std_dev_ms = std_dev_ms)
end

"""
    format_results(stats)

Formats the benchmark results (a NamedTuple produced by `run`) as a comma‑separated string:
`mean_ms,std_dev_ms,min_ms,max_ms,runs,result`
"""
function format_results(stats)
    return string(stats.mean_ms, ",", stats.std_dev_ms, ",", stats.min_ms, ",", stats.max_ms, ",", stats.runs, ",", stats.result)
end

end # module Benchmark
