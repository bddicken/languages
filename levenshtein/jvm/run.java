package jvm;

import languages.Benchmark;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

/**
 * This class implements the Levenshtein distance algorithm and provides
 * functionality
 * to benchmark it and provide output with benchmark results + for correctness
 * check.
 */
public class run {
    /**
     * Main method that processes command line arguments, reads the input file,
     * performs a benchmark warmup round of `sumLevenshteinDistances`, then
     * benchmarks it, and reports back the result as a csv row.
     *
     * @param args Command line arguments containing strings to compare
     */
    public static void main(String[] args) throws Exception {
        int runMs = Integer.parseInt(args[0]);
        int warmupMS = Integer.parseInt(args[1]);
        String inputPath = args[2];
        String content = Files.readString(Paths.get(inputPath));
        List<String> strings = Arrays.asList(content.split("\n\r?"));
        Benchmark.run(() -> levenshtein.distances(strings), warmupMS);
        var results = Benchmark.run(() -> levenshtein.distances(strings), runMs);
        var summedResults = results.withResult(results.result().stream()
                .mapToLong(Long::longValue)
                .sum());
        System.out.println(Benchmark.formatResults(summedResults));
    }
}
