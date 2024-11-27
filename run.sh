#!/bin/bash
function runOnce {
  { /usr/bin/time $2 ; } 2> /tmp/o 1> /dev/null
  if [ $? -ne 0 ]; then
    echo "Error occurred while running: $2"
    return 1
  fi
  printf "$1 = "
  cat /tmp/o | awk -v N=1 '{print $N"s"}'
}

function run {
  echo ""
  runOnce "$1" "$2"
  if [ $? -ne 0 ]; then return 1; fi
  runOnce "$1" "$2"
  if [ $? -ne 0 ]; then return 1; fi
  runOnce "$1" "$2"
}

# Activate the Python virtual environment before running benchmarks
source ./py/.venv/bin/activate

run "Kotlin" "java -jar kotlin/code.jar 40"
run "C" "./c/code 40" 
run "Go" "./go/code 40" 
run "Rust" "./rust/target/release/code 40"
run "Node" "node ./js/code.js 40" 
run "Bun" "bun ./js/code.js 40" 
run "Deno" "deno ./js/code.js 40" 
run "PyPy" "pypy ./py/code.py 40" 
run "Java" "java jvm.code 40"
run "Ruby" "ruby ./ruby/code.rb 40"
run "PHP" "php ./php/code.php 40"
run "R" "Rscript ./r/code.R 40"
run "Python" "python3 ./py/code.py 40" 
run "Dart" "./dart/code 40"
run "PyPy3 JIT" "python3 ./py/code_jit.py 40" 
run "Cython" "pypy3 ./py/run_code.py 40"