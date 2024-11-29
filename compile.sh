RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path ../custom-time/Cargo.toml --release
clang -O3 c/code.c -o c/code
go build -o go/code go/code.go
javac jvm/code.java
RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release
kotlinc -include-runtime kotlin/code.kt -d kotlin/code.jar
#kotlinc-native -include-runtime kotlin/code.kt -d kotlin/code
dart compile exe dart/code.dart -o dart/code --target-os=linux
sbcl --load ./lisp/code.lisp --eval '(sb-ext:save-lisp-and-die #P"lisp/code" :toplevel #'\''language-test:main :executable t)'
