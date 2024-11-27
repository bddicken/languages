if [[ $# -gt 0 ]]; then
    n_runs=$1
else
    n_runs=5
fi

if hash hyperfine 2>/dev/null; then
    echo -e "\n### Running "$n_runs"x the $(basename $PWD) benchmark ###\n"
    hyperfine \
        --setup 'bash ../compile.sh' --cleanup 'bash ../clean.sh' --runs $n_runs --show-output --export-markdown "$(basename $PWD).md" \
        'bun ./js/code.js 40' \
        './c/code 40' \
        './dart/code 40' \
        'deno ./js/code.js 40' \
        './go/code 40' \
        'java jvm.code 40' \
        'java -jar kotlin/code.jar 40' \
        'node ./js/code.js 40' \
        'php ./php/code.php 40' \
        'python3 ./py/code.py 40' \
        'Rscript ./r/code.R 40' \
        'ruby ./ruby/code.rb 40'
        # './rust/target/release/code 40' # throwing error when executing: toolchain 'nightly-x86_64-unknown-linux-gnu' is not installed
else
    echo "hyperfine is not installed. Please refer to https://github.com/sharkdp/hyperfine for installation instructions."
fi
