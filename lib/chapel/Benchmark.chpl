module Benchmark {
  use Time;
  use List;
  use IO;

  record BenchmarkResult {
    var meanMs: real;
    var stdDevMs: real;
    var minMs: real;
    var maxMs: real;
    var runs: int;
    var result: int;

    proc init(
      meanMs: real,
      stdDevMs: real,
      minMs: real,
      maxMs: real,
      runs: int,
      result: int
    ) {
      this.meanMs = meanMs;
      this.stdDevMs = stdDevMs;
      this.minMs = minMs;
      this.maxMs = maxMs;
      this.runs = runs;
      this.result = result;
    }
  }

  proc run(
    runMs: int,
    f,
    args...
  ): BenchmarkResult {
    if runMs <= 0 {
      return new BenchmarkResult(
        0.0,
        0.0,
        0.0,
        0.0,
        0,
        0
      );
    }

    var times: list(real);
    var totalElapsedMs = 0.0;
    var result = 0;

    while totalElapsedMs < runMs {
      var timer: stopwatch;

      timer.start();
      result = f((...args));
      timer.stop();

      const elapsedMs = timer.elapsed() * 1_000.0;

      times.pushBack(elapsedMs);
      totalElapsedMs += elapsedMs;
    }

    const runs = times.size;

    var sumMs = 0.0;
    var minMs = times[0];
    var maxMs = times[0];

    for elapsedMs in times {
      sumMs += elapsedMs;

      if elapsedMs < minMs {
        minMs = elapsedMs;
      }

      if elapsedMs > maxMs {
        maxMs = elapsedMs;
      }
    }

    const meanMs = sumMs / runs;

    var sumSquaredDifferences = 0.0;

    for elapsedMs in times {
      const difference = elapsedMs - meanMs;
      sumSquaredDifferences += difference * difference;
    }

    const stdDevMs = sqrt(sumSquaredDifferences / runs);

    return new BenchmarkResult(
      meanMs,
      stdDevMs,
      minMs,
      maxMs,
      runs,
      result
    );
  }

  proc formatResults(
    benchmark: BenchmarkResult,
    checksum: int
  ): string {
    return try! "%r,%r,%r,%r,%i,%i".format(
        benchmark.meanMs,
        benchmark.stdDevMs,
        benchmark.minMs,
        benchmark.maxMs,
        benchmark.runs,
        checksum
    );
  }

  proc formatResults(benchmark: BenchmarkResult): string {
    return formatResults(benchmark, benchmark.result);
  }
}