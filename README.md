# Languages

A repo for collaboratively building small benchmarks to compare languages.
If you have a suggestion for improvement: PR!
If you want to add a language: PR!

## Running

To run one of the benchmarks:

1. Install [Hyperfine](https://github.com/sharkdp/hyperfine?tab=readme-ov-file#installation)
2. `cd` into desired benchmark directory (EG `$ cd loops`)
3. Run via `$ bash ../run.sh`.
  You should see output something like:
  
  ```
  ### Running 5x the fibonacci benchmark ###
  Benchmark 1: bun ./js/code.js 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):      1.267 s ±  0.005 s    [User: 1.260 s, System: 0.011 s]
    Range (min … max):    1.262 s …  1.274 s    5 runs

  Benchmark 2: ./c/code 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140

    Warning: Statistical outliers were detected. Consider re-running this benchmark on a quiet system without any interferences from other programs. It might help to use the '--warmup' or '--prepare' options.
    Time (mean ± σ):     260.5 ms ±   3.1 ms    [User: 259.6 ms, System: 1.1 ms]
    Range (min … max):   258.9 ms … 266.1 ms    5 runs

  Benchmark 3: ./dart/code 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):      1.313 s ±  0.002 s    [User: 1.310 s, System: 0.003 s]
    Range (min … max):    1.310 s …  1.315 s    5 runs

  Benchmark 4: deno ./js/code.js 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):      2.073 s ±  0.014 s    [User: 2.056 s, System: 0.019 s]
    Range (min … max):    2.059 s …  2.090 s    5 runs

  Benchmark 5: ./go/code 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):      1.082 s ±  0.001 s    [User: 1.081 s, System: 0.004 s]
    Range (min … max):    1.079 s …  1.082 s    5 runs

  Benchmark 6: java jvm.code 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):     686.2 ms ±   1.2 ms    [User: 677.4 ms, System: 14.0 ms]
    Range (min … max):   685.4 ms … 688.2 ms    5 runs

  Benchmark 7: java -jar kotlin/code.jar 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):     698.5 ms ±   2.6 ms    [User: 695.0 ms, System: 21.6 ms]
    Range (min … max):   696.1 ms … 701.4 ms    5 runs

  Benchmark 8: node ./js/code.js 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):      1.903 s ±  0.003 s    [User: 1.898 s, System: 0.006 s]
    Range (min … max):    1.899 s …  1.907 s    5 runs

  Benchmark 9: php ./php/code.php 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140165580140165580140165580140165580140  Time (mean ± σ):     185.403 s ±  2.582 s    [User: 185.345 s, System: 0.049 s]
    Range (min … max):   182.242 s … 189.140 s    5 runs

  Benchmark 10: python3 ./py/code.py 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):     24.460 s ±  0.296 s    [User: 24.455 s, System: 0.004 s]
    Range (min … max):   24.145 s … 24.937 s    5 runs

  Benchmark 11: Rscript ./r/code.R 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):     162.857 s ±  0.975 s    [User: 162.856 s, System: 0.319 s]
    Range (min … max):   161.971 s … 164.449 s    5 runs

  Benchmark 12: ruby ./ruby/code.rb 40
  Generated: /home/runner/work/languages/languages/fibonacci/dart/code
  165580140
  165580140
  165580140
  165580140
  165580140
    Time (mean ± σ):     23.559 s ±  0.198 s    [User: 23.535 s, System: 0.023 s]
    Range (min … max):   23.371 s … 23.774 s    5 runs

  Summary
    ./c/code 40 ran
      2.63 ± 0.03 times faster than java jvm.code 40
      2.68 ± 0.03 times faster than java -jar kotlin/code.jar 40
      4.15 ± 0.05 times faster than ./go/code 40
      4.86 ± 0.06 times faster than bun ./js/code.js 40
      5.04 ± 0.06 times faster than ./dart/code 40
      7.30 ± 0.09 times faster than node ./js/code.js 40
      7.96 ± 0.11 times faster than deno ./js/code.js 40
     90.44 ± 1.33 times faster than ruby ./ruby/code.rb 40
     93.90 ± 1.60 times faster than python3 ./py/code.py 40
    625.18 ± 8.40 times faster than Rscript ./r/code.R 40
    711.73 ± 13.10 times faster than php ./php/code.php 40
  ```

## Adding

To add a language:

1. Select the benchmark directory you want to add to (EG `$ cd loops`)
2. Create a new subdirectory for the language (EG `$ mkdir rust`)
3. Implement the code in the appropriately named file (EG: `code.rs`)
4. If the language is compiled, add appropriate command to `../compile.sh` and `../clean.sh`
5. Add appropriate line to `../run.sh`

You are also welcome to add new top-level benchmarks dirs

# Available Benchmarks

## loops

Emphasizes loop, conditional, and basic math performance.

## fibonacci

Emphasizes function call overhead and recursion.
