clang -O3 c/code.c -o c/code
go build -o go/code go/code.go
javac jvm/code.java
RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release
kotlinc -include-runtime kotlin/code.kt -d kotlin/code.jar
#kotlinc-native -include-runtime kotlin/code.kt -d kotlin/code
dart compile exe dart/code.dart -o dart/code --target-os=macosa
#--------------------------------------------
#note:  assembly compiled on x86 machine
#nasm -f elf64 code.asm -o code.o
#gcc code.o -o code -no-pie -nostartfiles -lc
#--------------------------------------------
