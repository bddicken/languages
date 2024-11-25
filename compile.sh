clang -O3 c/code.c -o c/code
go build -ldflags "-s -w" -o go/code go/code.go
javac jvm/code.java
RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release
dart compile exe dart/code.dart -o dart/code --target-os=macos
scala-cli --power package scala/code.scala -f -o scala/code
ldc2 -O3 -release -boundscheck=off d/code.d
odin build odin/code.odin -o:speed -file
clang -framework Foundation objc/code.m -o code
gfortran -O3 fortran/code.f90 -o fortan/code
zig build-exe -O ReleaseFast -femit-bin=zig/code zig/code.zig
luajit -b lua/code.lua lua/code
swiftc -O -parse-as-library -Xcc -funroll-loops -Xcc -march=native -Xcc -ftree-vectorize -Xcc -ffast-math swift/code.swift -o swift/code
kotlinc-jvm -include-runtime kotlin/jvm/code.kt -d kotlin/jvm/code.jar
kotlinc-native kotlin/native/code.kt -o kotlin/native/code

# Kotlin/JS workaround
# https://youtrack.jetbrains.com/issue/KT-67089/K-JS-CLI-Compiling-.kt-.js-in-one-shot-is-not-possible
KOTLIN_HOME= # it should point to Kotlin home directory
BUILD_DIR=`pwd`/kotlin/js/build # it must be absolute path

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/libs # there should be two separate directories for KLIBs and JS
mkdir -p $BUILD_DIR/app

## first, build KLIB
$KOTLIN_HOME/bin/kotlinc-js \
  -Xir-produce-klib-file \
  -libraries $KOTLIN_HOME/lib/kotlin-stdlib-js.klib \
  -ir-output-dir $BUILD_DIR/libs \
  -ir-output-name code \
  kotlin/js/code.kt

## then, build JS
$KOTLIN_HOME/bin/kotlinc-js \
  -Xir-produce-js \
  -libraries $KOTLIN_HOME/lib/kotlin-stdlib-js.klib \
  -Xinclude=$BUILD_DIR/libs/code.klib \
  -ir-output-dir $BUILD_DIR/app \
  -ir-output-name code
