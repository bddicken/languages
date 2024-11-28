
function runOnce  {
  { time $2 ; } 2> /tmp/o 1> /dev/null
  printf "$1 = "
  cat /tmp/o | sed -n 's/real\s*\([0-9]*m\)\?\([0-9]*,[0-9]*\)s/\1 \2/p' | awk '{ min=($1 == "" ? 0 : $1) * 60; sec=$2; gsub(",", ".", sec); print min + sec }'
}

function run {
  echo ""
  runOnce "$1" "$2"
  runOnce "$1" "$2"
  runOnce "$1" "$2"
}

run "Kotlin" "java -jar kotlin/code.jar 40"
run "C" "./c/code 40"
run "Go" "./go/code 40"
run "Rust" "./rust/target/release/code 40"
run "Node" "node ./js/code.js 40"
run "Bun" "bun ./js/code.js 40"
run "Deno" "deno ./js/code.js 40"
run "PyPy" "pypy3 ./py/code.py 40"
run "Java" "java jvm.code 40"
run "Ruby" "ruby ./ruby/code.rb 40"
run "PHP" "php ./php/code.php 40"
run "R" "Rscript ./r/code.R 40"
run "Python" "python3 ./py/code.py 40"
run "Dart" "./dart/code 40"
run "lisp" "./lisp/code 40"
