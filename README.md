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
  Benchmark[loops] C = 1.24
  Benchmark[loops] Go = 1.48
  Benchmark[loops] Node = 1.93
  Benchmark[loops] Bun = 2.60
  Benchmark[loops] Deno = 1.79
  Benchmark[loops] PyPy = 5.31
  Benchmark[loops] Java = 1.32
  Benchmark[loops] Ruby = 67.46
  Benchmark[loops] PHP = 21.50
  Benchmark[loops] Rust = 1.20
  Benchmark[fibonacci] C = 0.28
  Benchmark[fibonacci] Go = 0.68
  Benchmark[fibonacci] Node = 1.61
  Benchmark[fibonacci] Bun = 1.00
  Benchmark[fibonacci] Deno = 1.67
  Benchmark[fibonacci] PyPy = 4.08
  Benchmark[fibonacci] Java = 0.48
  Benchmark[fibonacci] Ruby = 19.46
  Benchmark[fibonacci] PHP = 9.05
  Benchmark[fibonacci] Rust = 0.29
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
