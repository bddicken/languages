#!/bin/bash

# Defaults
check_only=false
skip_check=false
run_ms=10000
warmup_ms=2000
user="JDoe"
only_langs=false

while getopts "cst:w:u:l:h" opt; do
  case $opt in
    u) user="${OPTARG}" ;;          # Included in result file
    t) run_ms="${OPTARG}" ;;        # How long should the benchmark run?
    w) warmup_ms="${OPTARG}" ;;     # Warmup length
    c) check_only=true ;;           # Skip benchmark
    s) skip_check=true ;;           # Run benchmark even if check fails (typically with non-default input)
    l) only_langs="${OPTARG}" ;;    # Languages to benchmark, comma separated
    *) ;;
  esac
done
shift $((OPTIND-1))

only_langs_slug=""
if [ -n "${only_langs}" ] && [ "${only_langs}" != "false" ]; then
    only_langs_slug="_${only_langs//[^a-zA-Z0-9_-]/-}"
fi
IFS=',' read -r -a langs_array <<< "${only_langs}"

is_checked=true
if [ "$skip_check" = true ]; then
  is_checked=false
fi
user=${user//,/_}

override_input_value="${1}"

commit_sha=$(git rev-parse --short HEAD)
timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
timestamp_slug=$(echo "$timestamp" | tr ':' '-')
os=${OSTYPE//,/_}
arch=$(uname -m)

if [[ "${os}" == "darwin"* || "${os}" == "freebsd"* ]]; then
    model=$(sysctl -n machdep.cpu.brand_string)
elif [[ "${os}" == "linux-gnu"* ]]; then
    model=$(lscpu --extended=MODELNAME | awk -F: 'NR==2 {print $1; exit}')
else
    model="Unknown"
fi
model=${model//,/_}

if [[ "${os}" == "darwin"* || "${os}" == "freebsd"* ]]; then
  ram=$(sysctl -n hw.memsize)
  ram=$((ram / 1024 / 1024 / 1024))GB
elif [[ "${os}" == "linux-gnu"* ]]; then
  ram=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  ram=$((ram / 1024 / 1024))GB
else
  ram="Unknown"
fi

gcc_version=$(gcc --version | head -n 1 | tr ',' '_')
gpp_version=$(g++ --version | head -n 1 | tr ',' '_')
llvm_version=$(llvm-config --version | tr ',' '_')
clang_version=$(clang --version | head -n 1 | tr ',' '_')

results_dir="/tmp/languages-benchmark"
mkdir -p "${results_dir}"
results_file_name="${timestamp_slug}_${user}_${run_ms}_${commit_sha}${only_langs_slug}.csv"
results_file="${results_dir}/${results_file_name}"
if [ ! -f "${results_file}" ]; then
  echo "Results will be written to: ${results_file}"
  # Data header, must match what is printed from `run`
  echo "benchmark,timestamp,commit-sha,is-checked,user,model,ram,os,arch,gcc,g++,llvm,clang,language,run-ms,mean-ms,std-dev-ms,min-ms,max-ms,runs" > "${results_file}"

fi

function check {
  local language_name=${1}
  local partial_command=${2}
  local input_arg=${3}

  local command_line
  local program_output

  if [ ${skip_check} = false ]; then
    echo "Checking ${benchmark} ${language_name}"
    command_line="${partial_command} 1 0 ${input_arg}"
    echo ${command_line}
    program_output=$(${command_line})
    if ! ./check-output.sh "${program_output}"; then
      echo "Check failed for ${benchmark} ${language_name}."
      return 1
    fi
  else
    echo "Skipping check for ${benchmark} ${language_name}"
  fi
}

function run {
  # "Language" "File that should exist" "Partial command line"
  local language_name=${1}
  local file_that_should_exist=${2}
  local partial_command=${3}


  if [ "$only_langs" != false ]; then
    local should_run=false
    for lang in "${langs_array[@]}"; do
      if [ "$lang" = "$language_name" ]; then
        should_run=true
        break
      fi
    done
    if [ "$should_run" = false ]; then
      return
    fi
  fi

  use_hyperfine=false
  [[ "$benchmark" == "hello-world" ]] && use_hyperfine=true
  cmd_input="$(./check-output.sh -i)"
  if [ -n "${override_input_value}" ]; then
    cmd_input="${override_input_value}"
  fi

  local result
  echo
  if [ -f "${file_that_should_exist}" ]; then
    check "${language_name}" "${partial_command}" "${cmd_input}"
    if [ ${?} -eq 0 ] && [ ${check_only} = false ]; then
      echo "Benchmarking ${benchmark} ${language_name}"
      if [ ${use_hyperfine} = true ]; then
        local command_line="${partial_command} 1 0 ${cmd_input}"
        mkdir -p "${results_dir}/hyperfine"
        hyperfine_file="${results_dir}/hyperfine/${results_file_name}"
        hyperfine -i --shell=none --output=pipe --runs 25 --warmup 5 --export-csv "${hyperfine_file}" "${command_line}"
        result=$(tail -n +2 "${hyperfine_file}" | awk -F ',' '{print ($2*1000)","($3*1000)","($7*1000)","($8*1000)","25}')
      else
        local command_line="${partial_command} ${run_ms} ${warmup_ms} ${cmd_input}"
        echo "${command_line}"
        local program_output=$(eval "${command_line}")
        result=$(echo "${program_output}" | awk -F ',' '{print $1","$2","$3","$4","$5}')
      fi
      echo "${benchmark},${timestamp},${commit_sha},${is_checked},${user},${model},${ram},${os},${arch},${gcc_version},${gpp_version},${llvm_version},${clang_version},${language_name},${run_ms},${result}" | tee -a "${results_file}"
    fi
  else
    echo "No executable or script found for ${language_name}. Skipping."
  fi
}

function run_benchmark {
  local benchmark_dir=${1}
  local benchmark=$(basename ${benchmark_dir})
  cd "${benchmark_dir}" || return

  if [ "${check_only}" = false ]; then
    echo "Running ${benchmark} benchmark..."
  else
    echo "Only checking ${benchmark} benchmark"
    echo "No benchmark will be run"
  fi

  source ../languages.sh
  run_languages

  echo
  echo "Done running $(basename ${PWD}) benchmark"
}

run "Dart" "./dart/code 40"
run "Objective-C" "./objc/code 40"
run "Kotlin JVM" "java -jar kotlin/code.jar 40"
run "Kotlin Native" "./kotlin/code.kexe 40"
run "C" "./c/code 40"
run "Rust" "./rust/target/release/code 40"
run "Node" "node ./js/code.js 40" 
run "Bun" "bun ./js/code.js 40" 
run "Bun (Compiled)" "./js/bun 40" 
run "Deno" "deno ./js/code.js 40" 
run "PyPy" "pypy ./py/code.py 40" 
run "CPP" "./cpp/code 40"
run "Go" "./go/code 40"
run "Node (jitless)" "node --jitless ./js/code.js 40"
run "Bun (jitless)" "bun ./js/code.js 40" "BUN_JSC_useJIT=0"
run "Deno (jitless)" "deno --v8-flags=--jitless ./js/code.js 40"
run "PyPy" "pypy ./py/code.py 40"
run "Java" "java jvm.code 40"
#run "Java GraalVM" "./jvm.code 40"
run "Scala" "./scala/code 40"
run "Ruby" "ruby ./ruby/code.rb 40"
run "PHP JIT" "php -dopcache.enable_cli=1 -dopcache.jit=on -dopcache.jit_buffer_size=64M ./php/code.php 40"
run "PHP" "php ./php/code.php 40"
run "R" "Rscript ./r/code.R 40"
run "Python" "python3.13 ./py/code.py 40"
run "Common Lisp" "common-lisp/code 40"
run "Zig" "./zig/code 40"
run "Inko" "./inko/code 40"
run "Nim" "./nim/code 40"
run "Free Pascal" "./fpc/code 40"
run "Crystal" "./crystal/code 40"
#run "Ada" "./ada/code 40"
#run "D" "./d/code 40" # Seems to not have an arm / M1 version
run "Odin" "./odin/code 40"
run "Fortran" "./fortran/code 40" 
run "LuaJIT" "luajit ./lua/code 40"
run "Lua" "lua ./lua/code.lua 40"
run "Swift" "./swift/code 40"
run "Julia" "julia ./julia/code.jl 40"
#run "Haxe JVM" "java -jar haxe/code.jar 40" # was getting errors running `haxelib install hxjava`
run "Elixir" "elixir elixir/bench.exs 40"
#run "C# AOT" "./csharp-aot/code/csharp 40"
run "C#" "./csharp/code/csharp 40"
run "Ruby" "ruby ./ruby/code.rb 40"
run "Ruby YJIT" "miniruby --yjit ./ruby/code.rb 40"
run "Haskell" "./hs/code 40"
run "AWK" "awk -f ./awk/code.awk 40"
run "MAWK" "mawk -f ./awk/code.awk 40"
run "Clojure" "java -cp clojure/classes:$(clojure -Spath) code 40"
run "Babashka" "bb -cp clojure -m code 40"
run "Fish" "./fish/code.fish 40"
