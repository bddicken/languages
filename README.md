
# Languages

A repo for collaboratively building small benchmarks to compare languages.
If you have a suggestion for improvement: PR!
If you want to add a language: PR!

## Running

To run one of the benchmarks:

1. `cd` into desired benchmark directory (EG `$ cd loops`)
2. Compile by running `$ ../compile.sh`
3. Run via `$ ../run`.
  You should see output something like:
  
  ```
  $ ../run

  Benchmarking Zig
  Benchmark 1: ./zig/code 40
    Time (mean ± σ):     513.9 ms ±   2.9 ms    [User: 504.5 ms, System: 2.6 ms]
    Range (min … max):   510.6 ms … 516.2 ms    3 runs


  Benchmarking C
  Benchmark 1: ./c/code 40
    Time (mean ± σ):     514.0 ms ±   1.1 ms    [User: 505.6 ms, System: 2.8 ms]
    Range (min … max):   513.2 ms … 515.2 ms    3 runs


  Benchmarking Rust
  Benchmark 1: ./rust/target/release/code 40
    Time (mean ± σ):     514.1 ms ±   2.0 ms    [User: 504.6 ms, System: 3.1 ms]
    Range (min … max):   512.4 ms … 516.3 ms    3 runs

  ...
  ```

4. For good measure, execute `$ ../clean.sh` when finished.

Hyperfine is used to warm, execute, and time the runs of the programs.

## Adding

To add a language:

1. Select the benchmark directory you want to add to (EG `$ cd loops`)
2. Create a new subdirectory for the language (EG `$ mkdir rust`)
3. Implement the code in the appropriately named file (EG: `code.rs`)
4. If the language is compiled, add appropriate command to `../compile.sh` and `../clean.sh`
5. Add appropriate line to `../run`

You are also welcome to add new top-level benchmarks dirs

# Available Benchmarks

### [hello-world](./hello-world/README.md)

### [loops](./loops/README.md)

### [fibonacci](./fibonacci/README.md)

### [levenshtein](./levenshtein/README.md)

# Corresponding visuals

Several visuals have been published based on the work here.
More will likely be added in the future, as this repository improves:

- https://benjdd.com/languages
- https://benjdd.com/languages2
- https://benjdd.com/languages3
- https://pez.github.io/languages-visualizations/ 
  - check https://github.com/PEZ/languages-visualizations/tags for tags, which correspond to a snapshot of some particular benchmark run: e.g:
  - https://pez.github.io/languages-visualizations/v2024.12.31/
