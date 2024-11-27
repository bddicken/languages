#!/bin/bash

function run {
  echo "Benchmark[$1] $2 = $( { /usr/bin/time -f %e $3 >/dev/null; } 2>&1 )"
}

benchmarks=("loops" "fibonacci")

for dir in "${benchmarks[@]}"; do
    if [ -d "$dir" ]; then
        cd "$dir" || exit

		run "${dir}" "Kotlin" "java -jar kotlin/code.jar 40"
        run "${dir}" "C" "./c/code 40" 
        run "${dir}" "Go" "./go/code 40" 
        run "${dir}" "Rust" "./rust/target/release/code 40"
        run "${dir}" "Node" "node ./js/code.js 40" 
        run "${dir}" "Bun" "bun ./js/code.js 40" 
        run "${dir}" "Deno" "deno ./js/code.js 40" 
        run "${dir}" "PyPy" "pypy3 ./py/code.py 40" 
        run "${dir}" "Java" "java -cp java Code 40"
        run "${dir}" "Ruby" "ruby ./ruby/code.rb 40"
        run "${dir}" "PHP" "php ./php/code.php 40"
		run "${dir}" "R" "Rscript ./r/code.R 40"
		run "${dir}" "Python" "python3 ./py/code.py 40" 
		run "${dir}" "Dart" "./dart/code 40"

        cd .. || exit
    fi
done
