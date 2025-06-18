var runMs = int.Parse(args[0]);
var warmupMs = int.Parse(args[1]);
var n = int.Parse(args[2]);

Benchmark<int>.Run(() => Fibonacci(n), warmupMs);

var result = Benchmark<int>.Run(() => Fibonacci(n), runMs);

Console.WriteLine(result);

return;

static int Fibonacci(int n) =>
    n <= 1 ? n : Fibonacci(n - 1) + Fibonacci(n - 2);
