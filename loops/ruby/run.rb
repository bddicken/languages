require_relative '../../lib/ruby/benchmark'
require_relative './loops'

run_t = ARGV[0].to_i
warmup_t = ARGV[1].to_i
input = ARGV[2].to_i

bench(warmup_t) { loops(input) }

result = bench(run_t) { loops(input) }
puts format_bench(result)
