https://benjdd.com/languages/

# Languages

A repo for collaboratively building small benchmarks to compare languages.
If you have a suggestion for improvement: PR!
If you want to add a language: PR!

## Python

To install Python and use Conda for environment management, follow these steps:

### Installation

1. Install Python:
  - On Windows: `choco install python`
  - On macOS: `brew install python`
  - On Linux: Use your package manager, e.g., `sudo apt-get install python3`

2. Install Miniconda (a minimal installer for Conda):
  - Download the installer using `curl`:
    - On Windows:
      ```sh
      curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
      ```
    - On macOS:
      ```sh
      curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
      ```
    - On Linux:
      ```sh
      curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
      ```
  - Follow the installation instructions for your operating system

### Environment Management

1. Create a new Conda environment:
  ```sh
  conda create --name p3_13 python=3.13
  ```

2. Activate the environment:
  ```sh
  conda activate p3_13
  ```

3. Install necessary packages within the environment:
  ```sh
  conda install numpy pandas
  ```

4. Deactivate the environment when done:
  ```sh
  conda deactivate
  ```

5. To remove the environment:
  ```sh
  conda remove --name p3_13 --all
  ```

Using Conda helps manage dependencies and avoid conflicts between different projects.


## Compiling

Make sure you run with elevated privileges as not all projects compile without administrative access (e.g. dotnet for C#)
`sudo ../compile.sh`

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
