<<<<<<< HEAD
#!/bin/bash

benchmarks=("loops" "fibonacci")

for dir in "${benchmarks[@]}"; do
    if [ -d "$dir" ]; then
        cd "$dir" || exit
        
        rm -rf c/code
        rm -rf go/code
        rm -rf java/Code.class
        rm -rf rust/target
        rm -rf kotlin/code.jar
        rm -rf dart/code
        rm -rf d/code
        # rm -rf odin/code
        rm -rf objc/code
        rm -rf fortran/code
        rm -rf zig/code
        rm -rf lua/code
        rm -rf swift/code
        
        cd .. || exit
    fi
done
=======
rm c/code
rm go/code
rm jvm/code.class
rm -r rust/target
rm -rf kotlin/code.jar
rm dart/code
rm crystal/code
rm ada/code ada/code.ali ada/code.o
rm d/code
rm odin/code
rm objc/code
rm fortran/code
rm zig/code
rm lua/code
rm -f swift/code
>>>>>>> refs/remotes/bddicken/main
