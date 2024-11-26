#!/bin/bash
file=$1

function timeit {
  bash timeit.sh "$1" "$2 40"  >> runtime.txt
}

if [[ $file == */js/* ]]; then
  echo "Testing JavaScript file: $file"
  timeit "Node" "node $file"
  timeit "Bun" "bun $file"
  timeit "Deno" "deno $file"
elif [[ $file == */php/* ]]; then
  timeit "PHP" "php $file"
elif [[ $file == */py/* ]]; then
  echo "Testing Python file: $file"
  timeit "PyPy" "pypy $file"
  timeit "Python" "python3 $file"
elif [[ $file == */r/* ]]; then
  timeit "R" "Rscript $file"
elif [[ $file == */ruby/* ]]; then
  timeit "Ruby" "ruby $file"
else
  echo "No tests defined for $file"
fi