#!/bin/bash

function run {
  echo "Benchmark[$1] $2 = $( { /usr/bin/time -f %e $3 >/dev/null; } 2>&1 )"
}

<<<<<<< HEAD
benchmarks=("loops" "fibonacci")

for dir in "${benchmarks[@]}"; do
    if [ -d "$dir" ]; then
        cd "$dir" || exit

		run "${dir}" "Bun" "bun ./js/code.js 40" 
        run "${dir}" "C" "./c/code 40" 
		run "${dir}" "D" "./d/code 40" 
		run "${dir}" "Dart" "./dart/code 40"
        run "${dir}" "Deno" "deno ./js/code.js 40" 
		run "${dir}" "Fortran" "./fortran/code 40" 
        run "${dir}" "Go" "./go/code 40" 
        run "${dir}" "Java" "java -cp java Code 40"
		run "${dir}" "Julia" "julia ./julia/code.jl 40"
        run "${dir}" "Kotlin" "java -jar kotlin/code.jar 40"
		run "${dir}" "Lua" "lua ./lua/code.lua 40"
		run "${dir}" "Lua JIT" "luajit ./lua/code 40"
        run "${dir}" "Node" "node ./js/code.js 40" 
		echo "${dir}" "Objective-C" "Not supported on GNU/Linux"
		echo "${dir}" "Odin" "Not supported"
        run "${dir}" "Ruby YJIT" "miniruby --yjit ./ruby/code.rb 40"
		run "${dir}" "Rust" "./rust/target/release/code 40"
		run "${dir}" "Python" "python3 ./py/code.py 40"
        run "${dir}" "PHP" "php ./php/code.php 40"
        run "${dir}" "PHP JIT" "php -dopcache.enable_cli=1 -dopcache.jit=on ./php/code.php 40"
		run "${dir}" "R" "Rscript ./r/code.R 40"
        run "${dir}" "Ruby" "ruby ./ruby/code.rb 40"
        run "${dir}" "Scala" "./scala/code 40"
		run "${dir}" "Swift" "./swift/code 40"
		echo "${dir}" "Zig" "Doesn't compile"

        cd .. || exit
    fi
done
=======
run "Ruby YJIT" "miniruby --yjit ./ruby/code.rb 40"
run "Kotlin" "java -jar kotlin/code.jar 40"
run "C" "./c/code 40"
run "Go" "./go/code 40"
run "Rust" "./rust/target/release/code 40"
run "Node" "node ./js/code.js 40"
run "Bun" "bun ./js/code.js 40"
run "Deno" "deno ./js/code.js 40"
run "PyPy" "pypy ./py/code.py 40"
run "Java" "java jvm.code 40"
run "Scala" "./scala/code 40"
run "Ruby" "ruby ./ruby/code.rb 40"
run "PHP JIT" "php -dopcache.enable_cli=1 -dopcache.jit=on -dopcache.jit_buffer_size=64M ./php/code.php 40"
run "PHP" "php ./php/code.php 40"
run "R" "Rscript ./r/code.R 40"
run "Python" "python3 ./py/code.py 40"
run "Zig" "./zig/code 40"
run "Dart" "./dart/code 40"
run "Crystal" "./crystal/code 40"
run "Ada" "./ada/code 40"
run "D" "./d/code 40" 
run "Odin" "./odin/code 40"
run "Objective-C" "./objc/code 40"
run "Fortran" "./fortran/code 40" 
run "LuaJIT" "luajit ./lua/code 40"
run "Lua" "lua ./lua/code.lua 40"
run "Swift" "./swift/code 40"
run "Julia" "julia ./julia/code.jl 40"
>>>>>>> refs/remotes/bddicken/main
