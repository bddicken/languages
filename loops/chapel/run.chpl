use Benchmark;
use Random;

const LOOPS = 10_000;

proc loops(u: int): int {
  var a: [0..<LOOPS] int;

  var rng = new randomStream(int, seed=0);
  const r = rng.next() % LOOPS;

  for i in 0..<LOOPS {
    for j in 0..<LOOPS {
      a[i] += j % u;
    }

    a[i] += r;
  }

  return a[r];
}

proc main(args: [] string) {
  const runMs = args[1]: int;
  const warmupMs = args[2]: int;
  const u = args[3]: int;

  Benchmark.run(warmupMs, loops, u);

  const result = Benchmark.run(runMs, loops, u);

  writeln(Benchmark.formatResults(result));
}