# Languages

A repo for collaboratively building small benchmarks to compare languages.
If you have a suggestion for improvement: PR!
If you want to add a language: PR!

## Running

To run the benchmarks install Docker for your operating system and run the following from **languages** directory:

```
docker build -t languages .

docker run -it --name languages-container languages /bin/bash
```

1. Compile by running `$ ./compile.sh`
3. Run via `$ ./run.sh`.
  You should see output something like:
  
  ```
  $ bash ../run.sh
  Benchmark[loops] Kotlin = 1.34
  Benchmark[loops] C = 1.26
  Benchmark[loops] Go = 1.49
  Benchmark[loops] Rust = 1.27
  Benchmark[loops] Node = 1.66
  Benchmark[loops] Bun = 2.42
  Benchmark[loops] Deno = 1.62
  Benchmark[loops] PyPy = 5.24
  Benchmark[loops] Java = 1.35
  Benchmark[loops] Ruby = 68.56
  Benchmark[loops] PHP = 14.24
  Benchmark[loops] R = 175.21
  Benchmark[loops] Python = 125.74
  Benchmark[loops] Dart = 1.91
  Benchmark[fibonacci] Kotlin = 0.45
  Benchmark[fibonacci] C = 0.28
  Benchmark[fibonacci] Go = 0.64
  Benchmark[fibonacci] Rust = 0.29
  Benchmark[fibonacci] Node = 1.52
  Benchmark[fibonacci] Bun = 0.98
  Benchmark[fibonacci] Deno = 1.55
  Benchmark[fibonacci] PyPy = 4.11
  Benchmark[fibonacci] Java = 0.48
  Benchmark[fibonacci] Ruby = 19.53
  Benchmark[fibonacci] PHP = 9.04
  Benchmark[fibonacci] R = 158.52
  Benchmark[fibonacci] Python = 20.99
  Benchmark[fibonacci] Dart = 0.90
  $
  ```

4. For good measure, execute `$ bash ../clean.sh` when finished.

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
