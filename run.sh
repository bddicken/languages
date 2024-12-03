
function custom_run {
  echo ""
  ../custom-time/target/release/custom-time "$1" "$2"
}
function hf_run {
  echo ""
  echo "Benchmarking $1"
  hyperfine -i --shell=none --runs 3 --warmup 2 "$2"

}

function run {
  if [[ "$3" == "hf" ]]; then
    hf_run "$1" "$2"
  else
    custom_run "$1" "$2"
  fi
    
}

run "Ruby YJIT" "ruby --yjit ./ruby/code.rb 40" $1
run "Kotlin" "java -jar kotlin/code.jar 40" $1
run "C" "./c/code 40" $1
run "Rust" "./rust/target/release/code 40" $1
run "Node" "node ./js/code.js 40" $1
run "Bun" "bun ./js/code.js 40" $1
run "Bun (Compiled)" "./js/bun 40" $1
run "Deno" "deno ./js/code.js 40" $1
run "PyPy" "pypy ./py/code.py 40" $1
run "CPP" "./cpp/code 40" $1
run "Go" "./go/code 40" $1
run "Node (jitless)" "node --jitless ./js/code.js 40" $1
run "Bun (jitless)" "bun ./js/code.js 40" "BUN_JSC_useJIT=0" $1
run "Deno (jitless)" "deno --v8-flags=--jitless ./js/code.js 40" $1
run "PyPy" "pypy ./py/code.py 40" $1
run "Java" "java jvm.code 40" $1
run "Java GraalVM" "./jvm.code 40" $1
run "Scala" "./scala/code 40" $1
run "Ruby" "ruby ./ruby/code.rb 40" $1
run "PHP JIT" "php -dopcache.enable_cli=1 -dopcache.jit=on -dopcache.jit_buffer_size=64M ./php/code.php 40" $1
run "PHP" "php ./php/code.php 40" $1
run "R" "Rscript ./r/code.R 40" $1
run "Python" "python3.13 ./py/code.py 40" $1
run "Dart" "./dart/code 40" $1
run "Common Lisp" "common-lisp/code 40" $1
run "Zig" "./zig/code 40" $1
run "Dart" "./dart/code 40" $1
run "Inko" "./inko/code 40" $1
run "lisp" "sbcl --script ./lisp/code.lisp 40" $1
run "Nim" "./nim/code 40" $1
run "Free Pascal" "./fpc/code 40" $1
run "Crystal" "./crystal/code 40" $1
run "Ada" "./ada/code 40" $1
run "D" "./d/code 40" $1
run "Odin" "./odin/code 40" $1
run "Objective-C" "./objc/code 40" $1
run "Fortran" "./fortran/code 40" $1
run "LuaJIT" "luajit ./lua/code 40" $1
run "Lua" "lua ./lua/code.lua 40" $1
run "Swift" "./swift/code 40" $1
run "Julia" "julia ./julia/code.jl 40" $1
run "Haxe JVM" "java -jar haxe/code.jar 40" $1
run "Elixir" "elixir elixir/bench.exs 40" $1
run "C# AOT" "./csharp-aot/csharp 40" $1
run "C#" "./csharp/csharp 40" $1
run "Ruby" "ruby ./ruby/code.rb 40" $1
run "Haskell" "./hs/code 40" $1
