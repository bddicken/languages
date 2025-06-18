require_relative '../../lib/ruby/benchmark'
require_relative './levenshtein'

run_t = ARGV[0].to_i
warmup_t = ARGV[1].to_i
input = ARGV[2]

strings = File.readlines(input).map(&:chomp)

bench(warmup_t) { levenshtein(strings) }

result = bench(run_t) { levenshtein(strings) }
puts format_bench(result.merge(result: result[:result].sum))
