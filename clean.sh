#!/bin/bash

benchmarks=("loops" "fibonacci")

for dir in "${benchmarks[@]}"; do
    if [ -d "$dir" ]; then
        cd "$dir" || exit
        
        rm c/code
        rm go/code
        rm java/Code.class
        rm -r rust/target
        
        cd .. || exit
    fi
done
