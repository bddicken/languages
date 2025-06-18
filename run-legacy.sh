# We run the benchmark with input.txt as arguments
# unless the script is run with arguments, then those will be used instead
# With arguments the check will be skipped, unless the only argument is "check"
# The special argument "check" makes the input always input.txt, and skips the benchmark

num_script_args="${#}"
script_args="${*}"
if [ "${script_args}" = "check" ]; then
  input=$(cat input.txt)
else
  input=${script_args:-$(cat input.txt)}
fi

function check {
  if [ ${num_script_args} -eq 0 ] || [ "${script_args}" = "check" ]; then
    echo "Checking $1"
    output=$(${2} ${3})
    if ! ./check.sh "$output"; then
      echo "Check failed for $1."
      return 1
    fi
  fi
}

function run {
  echo ""
  if [ -f ${2} ]; then
    check "${1}" "${3}" "${4}"
    if [ ${?} -eq 0 ] && [ "${script_args}" != "check" ]; then
      cmd=$(echo "${3} ${4}" | awk '{ if (length($0) > 80) print substr($0, 1, 60) " ..."; else print $0 }')
      echo "Benchmarking $1"
      hyperfine -i --shell=none --output=pipe --runs 3 --warmup 2 -n "${cmd}" "${3} ${4}"
    fi
  else
    echo "No executable or script found for $1. Skipping."
  fi
}

run "Hare" "./hare/code 40"
# run "Language" "Executable" "Command" "Arguments"
#run "Ada" "./ada/code" "./ada/code" "${input}"
#run "AWK" "./awk/code.awk" "awk -f ./awk/code.awk" "${input}"
#run "Babashka" "bb/code.clj" "bb bb/code.clj" "${input}"
run "Bun (Compiled)" "./js/bun" "./js/bun" "${input}"
run "Bun (jitless)" "./js/code.js" "bun ./js/code.js" "BUN_JSC_useJIT=0" "${input}"
run "Bun" "./js/code.js" "bun ./js/code.js" "${input}"
run "C3" "./c3/code" "./c3/code" "${input}"
run "C" "./c/code" "./c/code" "${input}"
run "C#" "./csharp/legacy/code/code" "./csharp/legacy/code/code" "${input}"
run "C# AOT" "./csharp/legacy/code-aot/code" "./csharp/legacy/code-aot/code" "${input}"
run "Chez Scheme" "./chez/code.so" "chez --program ./chez/code.so" "${input}"
run "Clojure" "./clojure/classes/code.class" "java -cp clojure/classes:$(clojure -Spath) code" "${input}"
run "Clojure Native" "./clojure-native-image/code" "./clojure-native-image/code" "${input}"
run "COBOL" "./cobol/main" "./cobol/main" "${input}"
run "Common Lisp" "./common-lisp/code" "sbcl --script common-lisp/code.lisp" "${input}"
run "CPP" "./cpp/code" "./cpp/code" "${input}"
run "Crystal" "./crystal/code" "./crystal/code" "${input}"
#run "D" "./d/code" "./d/code" "${input}"
run "Dart" "./dart/code" "./dart/code" "${input}"
run "Deno (jitless)" "./js/code.js" "deno --v8-flags=--jitless ./js/code.js" "${input}"
run "Deno" "./js/code.js" "deno run ./js/code.js" "${input}"
run "Elixir" "./elixir/bench.exs" "elixir ./elixir/bench.exs" "${input}"
run "Emojicode" "./emojicode/code" "./emojicode/code" "${input}"
run "F#" "./fsharp/code/code" "./fsharp/code/code" "${input}"
run "F# AOT" "./fsharp/code-aot/code" "./fsharp/code-aot/code" "${input}"
run "Fortran" "./fortran/code" "./fortran/code" "${input}"
run "Free Pascal" "./fpc/code" "./fpc/code" "${input}"
run "Go" "./go/code" "./go/code" "${input}"
run "Haskell" "./haskell/code" "./haskell/code" "${input}"
#run "Haxe JVM" "haxe/code.jar" "java -jar haxe/code.jar" "${input}" # was getting errors running `haxelib install hxjava`
run "Inko" "./inko/code" "./inko/code" "${input}"
run "Java" "./jvm/code.class" "java jvm.code" "${input}"
run "Java Native" "./java-native-image/code" "./java-native-image/code" "${input}"
run "Julia" "./julia/code.jl" "julia ./julia/code.jl" "${input}"
run "Kotlin JVM" "kotlin/code.jar" "java -jar kotlin/code.jar" "${input}"
run "Kotlin Native" "./kotlin/code.kexe" "./kotlin/code.kexe" "${input}"
run "Lua" "./lua/code.lua" "lua ./lua/code.lua" "${input}"
run "LuaJIT" "./lua/code" "luajit ./lua/code" "${input}"
#run "MAWK" "./awk/code.awk" "mawk -f ./awk/code.awk" "${input}"
run "Modula 2" "./modula2/code" "./modula2/code" "${input}"
run "Nim" "./nim/code" "./nim/code" "${input}"
run "Node (jitless)" "./js/code.js" "node --jitles ./js/code.js" "${input}"
run "Node" "./js/code.js" "node ./js/code.js" "${input}"
run "Objective-C" "./objc/code" "./objc/code" "${input}"
#run "Octave" "./octave/code.m" "octave ./octave/code.m 40" "${input}"
run "Odin" "./odin/code" "./odin/code" "${input}"
run "PHP JIT" "./php/code.php" "php -dopcache.enable_cli=1 -dopcache.jit=on -dopcache.jit_buffer_size=64M ./php/code.php" "${input}"
run "PHP" "./php/code.php" "php ./php/code.php" "${input}"
run "PyPy" "./py/code.py" "pypy ./py/code.py" "${input}"
run "Python" "./py/code.py" "python3.12 ./py/code.py" "${input}"
run "Python JIT" "./py-jit/code.py" "python3.12 ./py-jit/code.py" "${input}"
#run "R" "./r/code.R" "Rscript ./r/code.R" "${input}"
run "Racket" "./racket/code" "./racket/code" "$input"
run "Ruby YJIT" "./ruby/code.rb" "miniruby --yjit ./ruby/code.rb" "${input}"
run "Ruby" "./ruby/code.rb" "ruby ./ruby/code.rb" "${input}"
run "Rust" "./rust/target/release/code" "./rust/target/release/code" "${input}"
run "Scala" "./scala/code" "./scala/code" "${input}"
run "Scala-Native" "./scala/code-native" "./scala/code-native" "${input}"
run "Bun Scala-JS(Compiled)" "./scala/bun" "./scala/bun" "${input}"
run "Bun Scala-JS" "./scala/code.js" "bun ./scala/code.js" "${input}"
run "Swift" "./swift/code" "./swift/code" "${input}"
run "V" "./v/code" "./v/code" "${input}"
run "Zig" "./zig/code" "./zig/code" "${input}"
run "Emacs Lisp Bytecode" "./emacs-lisp/code.elc" "emacs -Q --batch --load ./emacs-lisp/code.elc" "${input}"
run "Emacs Lisp Native" "./emacs-lisp/code.eln" "emacs -Q --batch --load ./emacs-lisp/code.eln" "${input}"
