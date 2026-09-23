use Benchmark;

proc fibonacci(n: int): int {
  if n < 2 {
    return n;
  }

  return fibonacci(n - 1) + fibonacci(n - 2);
}

proc main(args: [] string) {
  const runMs = args[1]: int;
  const warmupMs = args[2]: int;
  const n = args[3]: int;

  Benchmark.run(warmupMs, fibonacci, n);

  const result = Benchmark.run(runMs, fibonacci, n);

  writeln(Benchmark.formatResults(result));
}