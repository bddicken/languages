clang -O3 c/code.c -o c/code
go build -o go/code go/code.go
javac jvm/code.java
RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release
kotlinc -include-runtime kotlin/code.kt -d kotlin/code.jar
nim c --define:release --passC:"-O3" --define:speed --define:danger --out:nim/code nim/code.nim
#kotlinc-native -include-runtime kotlin/code.kt -d kotlin/code
dart compile exe dart/code.dart -o dart/code --target-os=macos
