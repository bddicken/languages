package languages;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Supplier;

public class Benchmark {
  public record BenchmarkResult<T>(
      double meanMs,
      double stdDevMs,
      double minMs,
      double maxMs,
      int runs,
      T result) {
    public <R> BenchmarkResult<R> withResult(R newResult) {
      return new BenchmarkResult<>(meanMs, stdDevMs, minMs, maxMs, runs, newResult);
    }
  }

  private record TimedResult<T>(long totalElapsedTime, long elapsedTime, T result) {
  }

  /* Calculates statistics in ms for input in ns */
  private static class Stats {
    final double meanMs;
    final double stdDevMs;
    final double minMs;
    final double maxMs;
    final int runs;

    Stats(long totalElapsedTimeNs, List<Long> elapsedTimesNs) {
      this.runs = elapsedTimesNs.size();
      this.meanMs = elapsedTimesNs.stream()
          .mapToDouble(t -> t / 1_000_000.0)
          .average()
          .orElse(0.0);

      double variance = elapsedTimesNs.stream()
          .mapToDouble(t -> t / 1_000_000.0)
          .map(t -> t - meanMs)
          .map(d -> d * d)
          .average()
          .orElse(0.0);

      this.stdDevMs = Math.sqrt(variance);
      this.minMs = elapsedTimesNs.stream()
          .mapToDouble(t -> t / 1_000_000.0)
          .min()
          .orElse(0.0);
      this.maxMs = elapsedTimesNs.stream()
          .mapToDouble(t -> t / 1_000_000.0)
          .max()
          .orElse(0.0);
    }
  }

  /**
   * Runs `f` repeatedly measuring the time delta in nanoseconds.
   * Stops when the sum of the deltas is larger than `runMs`.
   * Returns a record with stats and result.
   * runMs: 0 => don't run, 1 => this is a check-output run
   * NB: If `f` takes sub-milliseconds to run, this function can run for very long
   * because of the overhead of looping so many times.
   */
  public static <T> BenchmarkResult<T> run(Supplier<T> f, long runMs) {
    if (runMs == 0) {
      return null;
    }
    
    long runNs = runMs * 1_000_000;
    List<TimedResult<T>> results = new ArrayList<>();
    long totalElapsedTime = 0;
    long lastStatusT = System.nanoTime();

    if (runMs > 1) { // Start with printing a status dot, except if check-output run
      System.err.print(".");
      System.err.flush();
    }
    while (totalElapsedTime < runNs) {
      long t0 = System.nanoTime();
      T result = f.get();
      long t1 = System.nanoTime();
      long elapsedTime = t1 - t0;
      // Only print status dot if not check-output run
      if (runMs > 1 && t0 - lastStatusT > 1_000_000_000) {
        lastStatusT = t1;
        System.err.print(".");
        System.err.flush();
      }
      totalElapsedTime += elapsedTime;
      results.add(new TimedResult<>(totalElapsedTime, elapsedTime, result));
    }
    if (runMs > 1) { // No status printed for check-output runs
      System.err.println();
    }

    TimedResult<T> lastResult = results.get(results.size() - 1);
    List<Long> elapsedTimes = results.stream()
        .map(r -> r.elapsedTime)
        .toList();

    Stats stats = new Stats(lastResult.totalElapsedTime, elapsedTimes);
    return new BenchmarkResult<>(
        stats.meanMs,
        stats.stdDevMs,
        stats.minMs,
        stats.maxMs,
        stats.runs,
        lastResult.result);
  }

  /**
   * Formats the benchmark results into a comma-separated string.
   */
  public static String formatResults(BenchmarkResult<?> result) {
    return String.format("%.6f,%.6f,%.6f,%.6f,%d,%s",
        result.meanMs,
        result.stdDevMs,
        result.minMs,
        result.maxMs,
        result.runs,
        result.result);
  }
}
