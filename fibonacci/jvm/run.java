package jvm;

import languages.Benchmark;
import jvm.fibonacci;

public class run {
    public static void main(String[] args) {
        var runMs = Integer.parseInt(args[0]);
        var warmupMS = Integer.parseInt(args[1]);
        var n = Integer.parseInt(args[2]);
        Benchmark.run(() -> fibonacci.fib(n), warmupMS);
        var results = Benchmark.run(() -> fibonacci.fib(n), runMs);
        System.out.println(Benchmark.formatResults(results));
    }
}
