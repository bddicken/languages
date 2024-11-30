clang -O3 c/code.c -o c/code
go build -ldflags "-s -w" -o go/code go/code.go
javac jvm/code.java
cargo build --manifest-path rust/Cargo.toml --release
kotlinc -include-runtime kotlin/code.kt -d kotlin/code.jar
#kotlinc-native -include-runtime kotlin/code.kt -d kotlin/code
dart compile exe dart/code.dart -o dart/code --target-os=macos
crystal build -o crystal/code --release crystal/code.cr
gnatmake -O3 -gnat2022 -gnatp -flto ada/code.adb -D ada -o ada/code
scala-cli --power package scala/code.scala -f -o scala/code
ldc2 -O3 -release -boundscheck=off d/code.d
odin build odin/code.odin -o:speed -file
clang -framework Foundation objc/code.m -o code
gfortran -O3 fortran/code.f90 -o fortan/code
zig build-exe -O ReleaseFast -femit-bin=zig/code zig/code.zig
luajit -b lua/code.lua lua/code
swiftc -O -parse-as-library -Xcc -funroll-loops -Xcc -march=native -Xcc -ftree-vectorize -Xcc -ffast-math swift/code.swift -o swift/code
