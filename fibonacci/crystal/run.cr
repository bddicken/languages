require "./fibonacci.cr"
require "../../lib/crystal/benchmark.cr"

run_t = ARGV[0].to_i
warmup_t = ARGV[1].to_i
input = ARGV[2].to_i

bench(warmup_t) { fibonacci(input) }

result = bench(run_t) { fibonacci(input) }
puts format_bench(result, &.itself)