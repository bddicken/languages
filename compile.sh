#!/bin/bash

benchmarks=("loops" "fibonacci")

for dir in "${benchmarks[@]}"; do
    if [ -d "$dir" ]; then
        cd "$dir" || exit

        clang -O3 c/code.c -o c/code
        go build -o go/code go/code.go
        javac java/Code.java
        RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release 

        cd .. || exit
    fi
done
