module Enumerable
    def variance
      mean = self.sum / self.size
      sum = self.reduce(0) { |acc, cur| acc + (cur-mean) ** 2 }
      sum/(self.size - 1).to_f
    end

    def std_dev
      Math.sqrt(self.variance)
    end
end

def bench(run_ms : Int32, &fn)
	times = Array(Int64).new
	result = 0
	secs = 0
	run_ns = run_ms * 1_000_000.0

	while(times.sum < run_ns && !(times.sum == 0 && times.size > 0))
		a = Time.measure {result = yield}
		times << a.nanoseconds

		if (times.sum / 1_000_000_000).round > secs
			STDERR.print '.'
			secs += 1
		end
	end
	STDERR.puts

	{times: times, result: result}
end

def format_bench(data, &formatter)
	raise "no data!" if data[:times].empty?

	result = yield data[:result]
	times = data[:times].map &./(1_000_000)

	# mean_ms,std-dev-ms,min_ms,max_ms,times,result
	"#{times.sum/times.size},#{times.std_dev},#{times.min},#{times.max},#{times.size},#{result}"
end