clang -O3 c/code.c -o c/code
clang++ -std=c++23 -march=native -O3 -Ofast -o cpp/code cpp/code.cpp
go build -ldflags "-s -w" -o go/code go/code.go
javac jvm/code.java
bun build --bytecode --compile js/code.js --outfile js/bun
native-image -O3 jvm.code
RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release
cargo build --manifest-path rust/Cargo.toml --release
kotlinc -include-runtime kotlin/code.kt -d kotlin/code.jar
#kotlinc-native -include-runtime kotlin/code.kt -d kotlin/code
dart compile exe dart/code.dart -o dart/code --target-os=macos
cd inko && inko build --opt=aggressive code.inko -o code && cd ..
nim c -d:danger --opt:speed nim/code.nim
sbcl --noinform --non-interactive --load "common-lisp/code.lisp" --build
fpc -O3 fpc/code.pas
crystal build -o crystal/code --release crystal/code.cr
#gnatmake -O3 -gnat2022 -gnatp -flto ada/code.adb -D ada -o ada/code
scala-cli --power package scala/code.scala -f -o scala/code
ldc2 -O3 -release -boundscheck=off d/code.d
odin build odin/code.odin -o:speed -file -out:odin/code
clang -O3 -framework Foundation objc/code.m -o objc/code
gfortran -O3 fortran/code.f90 -o fortran/code
zig build-exe -O ReleaseFast -femit-bin=zig/code zig/code.zig
luajit -b lua/code.lua lua/code
swiftc -O -parse-as-library -Xcc -funroll-loops -Xcc -march=native -Xcc -ftree-vectorize -Xcc -ffast-math swift/code.swift -o swift/code
# haxe --class-path haxe -main Code --jvm haxe/code.jar # was getting errors running `haxelib install hxjava`
#dotnet publish csharp/csharp.csproj -o csharp/code-aot /p:PublishAot=true
dotnet publish csharp/csharp.csproj -o csharp/code
ghc -O2 -fllvm haskell/code.hs -o haskell/code || { echo "ghc: cannot compile with llvm backend; fallback to use default backend"; ghc -O2 haskell/code.hs -o haskell/code; }
