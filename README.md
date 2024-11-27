# Languages

A repo for collaboratively building small benchmarks to compare languages.
If you have a suggestion for improvement: PR!
If you want to add a language: PR!

## Running

To run one of the benchmarks:

1. `cd` into desired benchmark directory (EG `$ cd loops`)
2. Compile by running `$ bash ../compile.sh`
3. Run via `$ bash ../run.sh`.
  You should see output something like:
  
  ```
  $ bash ../run.sh
  C = 0.77
  Go = 2.07
  Node = 0.79
  Bun = 0.83
  Deno = 1.13
  PyPy = 1.61
  Java = 0.64
  $
  ```

4. For good measure, execute `$ bash ../clean.sh` when finished.

### Interpretation

The numbers represent the real execution time (wall-clock time) it took for each language to execute the given task. **A lower number indicates better performance.**

`bash ../run.sh` runs each program three times using the `runOnce` function and `awk` captures the real execution time.

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
