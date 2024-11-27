function runOnce  {
  { /usr/bin/time $2 ; } 2> /tmp/o 1> /dev/null
  printf "$1 = "
  time_result=$(cat /tmp/o | awk -v N=1 '{print $N}')
  echo "$time_result"
  echo "$1 = $time_result" >> /tmp/benchmark_results
}

function run {
  echo ""
  runOnce "$1" "$2"
  runOnce "$1" "$2"
  runOnce "$1" "$2"
}

# Clear previous results
rm -f /tmp/benchmark_results

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

# Get the directory where run.sh is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run the benchmark viewer if environment is properly set up
if [ -f "$SCRIPT_DIR/benchmark_viewer.py" ] && [ -f "$SCRIPT_DIR/requirements.txt" ]; then
    if [ ! -d "$SCRIPT_DIR/venv" ]; then
        echo "Python environment not found. Setting up..."
        cd "$SCRIPT_DIR"
        python3 -m venv venv
        ./venv/bin/pip install -r requirements.txt
        cd - > /dev/null
    fi
    echo -e "\nDisplaying benchmark visualization..."
    "$SCRIPT_DIR/venv/bin/python" "$SCRIPT_DIR/benchmark_viewer.py"
fi
