require 'benchmark'

def variance(array)
  mean = array.sum / array.size.to_f
  sum = array.reduce(0) { |acc, cur| acc + (cur - mean) ** 2 }
  sum / (array.size - 1).to_f
end

def std_dev(array)
  Math.sqrt(variance(array))
end

def bench(run_ms)
  times = []
  result = 0
  secs = 0
  run_ns = run_ms * 1_000_000.0

  while (times.sum < run_ns && !(times.sum == 0 && times.size > 0))
    time = Benchmark.measure { result = yield }.real * 1_000_000_000
    times << time

    if run_ms > 1 && (times.sum / 1_000_000_000).round > secs
      STDERR.print '.'
      secs += 1
    end
  end
  STDERR.puts if run_ms > 1

  { times: times, result: result }
end

def format_bench(data)
  raise "no data!" if data[:times].empty?

  result = data[:result]
  times = data[:times].map { |t| t / 1_000_000.0 }

  # mean_ms,std-dev-ms,min_ms,max_ms,times,result
  "#{times.sum / times.size},#{std_dev(times)},#{times.min},#{times.max},#{times.size},#{result}"
end
