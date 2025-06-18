using System.Diagnostics;

public static class Benchmark<T>
{
    public static BenchmarkResult<T>? Run(Func<T> func, int runMs)
    {
        if (runMs <= 0)
        {
            return null;
        }

        var runNs = runMs * 1_000_000L;

        var runs = 0;
        var sum = 0L;
        var min = long.MaxValue;
        var max = 0L;
        var sumSq = 0L;

        T lastResult = default!;

        var lastTime = Stopwatch.GetTimestamp();

        while (sum < runNs)
        {
            var startTime = Stopwatch.GetTimestamp();
            lastResult = func();
            var endTime = Stopwatch.GetTimestamp();

            var elapsed = endTime - startTime;

            runs++;

            sum += elapsed;
            sumSq += elapsed * elapsed;

            min = Math.Min(min, elapsed);
            max = Math.Max(max, elapsed);

            if (runMs > 1 && (startTime - lastTime) > Stopwatch.Frequency)
            {
                lastTime = endTime;
                Console.Error.Write('.');
            }
        }

        if (runMs > 1)
        {
            Console.Error.WriteLine();
        }

        var mean = (double)sum / runs;
        var variance = (double)sumSq / runs - Math.Pow(mean, 2);
        var stdDev = Math.Sqrt(variance);

        var ticksToMs = 1000D / Stopwatch.Frequency;

        return new BenchmarkResult<T>(
            mean * ticksToMs,
            stdDev * ticksToMs,
            min * ticksToMs,
            max * ticksToMs,
            runs,
            lastResult);
    }
}


public record BenchmarkResult<T>(
    double MeanMs,
    double StdDevMs,
    double MinMs,
    double MaxMs,
    int Runs,
    T Result)
{
    public override string ToString()
    {
        return $"{MeanMs:F6},{StdDevMs:F6},{MinMs:F6},{MaxMs:F6},{Runs},{Result}";
    }
};
