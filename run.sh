n=40

function runOnce  {
  { /usr/bin/time $2 ; } 2> /tmp/o 1> /dev/null
  printf "$1 = "
  tail /tmp/o | awk -v N=1 '{print $N"s"}'
}

function run {
  { $2 1>/dev/null 2>/dev/null; } || { echo "$1 missing"; return 1; }
  echo ""
  runOnce "$1" "$2"
  runOnce "$1" "$2"
  runOnce "$1" "$2"
}

run "Kotlin" "java -jar kotlin/code.jar $n"
run "Scala" "java -jar scala/code.jar $n"
run "C" "./c/code $n" 
run "Go" "./go/code $n" 
run "Rust" "./rust/target/release/code $n"
run "Node" "node ./js/code.js $n" 
run "Bun" "bun ./js/code.js $n" 
run "Deno" "deno ./js/code.js $n" 
run "PyPy" "pypy ./py/code.py $n" 
run "Java" "java jvm.code $n"
run "Ruby" "ruby ./ruby/code.rb $n"
run "PHP" "php ./php/code.php $n"
run "R" "Rscript ./r/code.R $n"
run "Python" "python3 ./py/code.py $n" 
run "Dart" "./dart/code $n"
