#!/bin/bash

benchmark=$(basename "${PWD}")

# Defaults
only_langs=false

while getopts "cst:u:l:h" opt; do
  case $opt in
    l) only_langs="${OPTARG}" ;;    # Languages to benchmark, comma separated
    *) ;;
  esac
done
shift $((OPTIND-1))

if [ -n "${only_langs}" ] && [ "${only_langs}" != "false" ]; then
    IFS=',' read -r -a only_langs <<< "${only_langs}"
fi

function compile {
  local language_name=${1}
  local directory=${2}
  local compile_cmd=${3}

  if [ "$only_langs" != false ]; then
    local should_run=false
    for lang in "${only_langs[@]}"; do
      if [ "$lang" = "$language_name" ]; then
        should_run=true
        break
      fi
    done
    if [ "$should_run" = false ]; then
      return
    fi
  fi

  if [ -d ${directory} ]; then
    echo ""
    echo "Compiling ${language_name}"
    echo "${compile_cmd}"
    eval "${compile_cmd}"
    result=$?
    if [ $result -ne 0 ]; then
        echo "Failed to compile ${language_name} with command: ${compile_cmd}"
    fi
  fi
}

function compile_benchmark {
  local benchmark_dir=${1}
  local benchmark=$(basename ${benchmark_dir})
  cd "${benchmark_dir}" || return

  echo "Starting compiles for ${benchmark}"

  source ../languages.sh
  compile_languages

  echo
  echo "Done with compiles for ${benchmark}"
}

available_benchmarks=("loops" "fibonacci" "levenshtein" "hello-world")
benchmarks_to_compile=()
current_benchmark=$(basename "${PWD}")

benchmark_found=false
for benchmark in "${available_benchmarks[@]}"; do
  if [[ "${benchmark}" == "${current_benchmark}" ]]; then
    benchmark_found=true
    break
  fi
done

if [ "${benchmark_found}" = true ]; then
  benchmarks_to_compile=("${PWD}")
else
  for benchmark in "${available_benchmarks[@]}"; do
    if [ -d "${PWD}/${benchmark}" ]; then
      benchmarks_to_compile+=("${PWD}/${benchmark}")
    fi
  done
fi

for benchmark_dir in "${benchmarks_to_compile[@]}"; do
  compile_benchmark "${benchmark_dir}"
done