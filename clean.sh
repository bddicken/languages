#!/bin/bash

function clean_benchmark {
  local benchmark_dir=${1}
  local benchmark=$(basename ${benchmark_dir})
  cd "${benchmark_dir}" || return

  echo "Cleaning ${benchmark}"

  rm c3/code
  rm c/{code,run}
  rm cpp/code
  rm go/code
  rm -rf jvm/{*.class,*.iprof}
  rm -rf java-native-image/{jvm.run,run,code,jvm.code,*.iprof}
  rm scala/code scala/code-native
  rm -rf rust/{Cargo.lock,target} ../lib/rust/{Cargo.lock,target}
  rm -rf kotlin/code.jar
  rm kotlin/code.kexe
  rm dart/code
  rm -rf inko/build inko/code
  rm nim/code
  rm js/bun
  rm common-lisp/code
  rm fpc/code
  rm modula2/code
  rm crystal/{code,run,gc.dll,iconv.dll,*.pdb,*.dll}
  rm ada/code ada/code.ali ada/code.o
  rm d/code
  rm odin/code
  rm objc/code
  rm fortran/code
  rm -rf zig/{code,code.o} zig/{.zig-cache,zig-out}
  rm lua/code
  rm -f swift/code
  rm haxe/code.jar
  rm -rf csharp/bin
  rm -rf csharp/obj
  rm -rf csharp/code-aot
  rm -rf csharp/code
  rm -rf fsharp/bin
  rm -rf fsharp/obj
  rm -rf fsharp/code-aot
  rm -rf fsharp/code
  rm haskell/code haskell/*.hi haskell/*.o
  rm hare/code
  rm v/code
  rm emojicode/code emojicode/code.o
  rm -f chez/code.so
  rm -rf clojure/{classes,.cpcache,*.class}
  rm -rf clojure-native-image/{classes,code,run,*.iprof}
  rm cobol/main
  rm emacs-lisp/code.eln emacs-lisp/code.elc
  rm -rf ../lib/py/__pycache__/
  rm -rf py/__pycache__/
  rm -rf py-jit/__pycache__/
  (cd ../lib/maelg/benchmark; gleam clean)
  (cd maelg; gleam clean)
}

available_benchmarks=("loops" "fibonacci" "levenshtein" "hello-world")
benchmarks_to_clean=()
current_benchmark=$(basename "${PWD}")

benchmark_found=false
for benchmark in "${available_benchmarks[@]}"; do
  if [[ "${benchmark}" == "${current_benchmark}" ]]; then
    benchmark_found=true
    break
  fi
done

if [ "${benchmark_found}" = true ]; then
  benchmarks_to_clean=("${PWD}")
else
  for benchmark in "${available_benchmarks[@]}"; do
    if [ -d "${PWD}/${benchmark}" ]; then
      benchmarks_to_clean+=("${PWD}/${benchmark}")
    fi
  done
fi

for benchmark_dir in "${benchmarks_to_clean[@]}"; do
  echo
  clean_benchmark "${benchmark_dir}"
done