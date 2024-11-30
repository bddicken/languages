#!/bin/bash

benchmarks=("loops" "fibonacci")

for dir in "${benchmarks[@]}"; do
    if [ -d "$dir" ]; then
        cd "$dir" || exit

        echo "Compiling $dir/c" && clang -O3 c/code.c -o c/code
        echo "Compiling $dir/go" && go build -ldflags "-s -w" -o go/code go/code.go
        echo "Compiling $dir/java" && javac java/Code.java
        echo "Compiling $dir/rust" && RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release
        echo "Compiling $dir/kotlin" && kotlinc -include-runtime kotlin/code.kt -d kotlin/code.jar
        echo "Compiling $dir/dart" && dart compile exe dart/code.dart -o dart/code --target-os=linux
        echo "Compiling $dir/scala" && scala-cli --power package scala/code.scala -f -o scala/code
		echo "Compiling $dir/ldc2" && ldc2 -O3 -release -boundscheck=off d/code.d
		echo "Compiling $dir/odin" && echo "Not supported" #odin build odin/code.odin -o:speed -file -platform offscreen
		echo "Compiling $dir/objc" && echo "Not supported on GNU/Linux" #clang -framework Foundation objc/code.m -o code
		echo "Compiling $dir/fortran" && gfortran -O3 fortran/code.f90 -o fortran/code
		echo "Compiling $dir/zig" && echo "Doesnt' compile" #zig build-exe --release-fast --output-dir zig zig/code.zig
		echo "Compiling $dir/luajit" && luajit -b lua/code.lua lua/code
		echo "Compiling $dir/swift" && swiftc -O -parse-as-library -Xcc -funroll-loops -Xcc -march=native -Xcc -ftree-vectorize -Xcc -ffast-math swift/code.swift -o swift/code

        cd .. || exit
    fi
done
