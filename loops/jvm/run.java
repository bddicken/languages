package jvm;

import java.util.Random;
import languages.Benchmark;

public class run {

    private static int loops(int u) {
        var r = new Random().nextInt(10000); // Get a random number 0 <= r < 10k
        var a = new int[10000]; // Array of 10k elements initialized to 0
        for (var i = 0; i < 10000; i++) { // 10k outer loop iterations
            for (var j = 0; j < 10000; j++) { // 10k inner loop iterations, per outer loop iteration
                a[i] = a[i] + j % u; // Simple sum
            }
            a[i] += r; // Add a random value to each element in array
        }
        return a[r];
    }

    public static void main(String[] args) {
        var runMs = Integer.parseInt(args[0]);
        var warmupMS = Integer.parseInt(args[1]);
        var n = Integer.parseInt(args[2]);
        Benchmark.run(() -> loops(n), warmupMS);
        var results = Benchmark.run(() -> loops(n), runMs);
        System.out.println(Benchmark.formatResults(results));
    }
}
