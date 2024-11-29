RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path ../custom-time/Cargo.toml --release
clang -O3 c/code.c -o c/code
go build -ldflags "-s -w" -o go/code go/code.go
javac jvm/code.java
RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release
kotlinc -include-runtime kotlin/code.kt -d kotlin/code.jar
#kotlinc-native -include-runtime kotlin/code.kt -d kotlin/code
dart compile exe dart/code.dart -o dart/code --target-os=linux
scala-cli --power package scala/code.scala -f -o scala/code
ldc2 -O3 -release -boundscheck=off d/code.d -of=d/code
odin build odin/code.odin -o:speed -file -out:odin/code
clang -fconstant-string-class=NSConstantString \
    $(gnustep-config --objc-flags) \
    $(gnustep-config --objc-libs) \
    -lgnustep-base -lobjc objc/code.m -o objc/code
gfortran -O3 fortran/code.f90 -o ./fortran/code
zig build-exe -O ReleaseFast -femit-bin=zig/code zig/code.zig
luajit -b lua/code.lua lua/code
swiftc -target x86_64-unknown-linux-gnu -O -parse-as-library -Xcc -funroll-loops -Xcc -march=native -Xcc -ftree-vectorize -Xcc -ffast-math swift/code.swift -o swift/code
