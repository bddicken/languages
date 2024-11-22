function run {
  { /usr/bin/time $2 ; } 2> /tmp/o 1> /dev/null
  printf "$1 = "
  cat /tmp/o | awk -v N=1 '{print $N"s"}'
}

run "C" "./c/code 40" 
run "Go" "./go/code 40" 
run "Rust" "./rust/target/release/code 40"
run "Node" "node ./js/code.js 40" 
run "Bun" "bun ./js/code.js 40" 
run "Deno" "deno ./js/code.js 40" 
run "PyPy" "pypy ./py/code.py 40" 
run "Cython" "python3 ./pyx/code.py 40"
run "Java" "java jvm.code 40"
run "Ruby" "ruby ./ruby/code.rb 40"
run "PHP" "php ./php/code.php 40"
run "R" "Rscript ./r/code.R 40"
