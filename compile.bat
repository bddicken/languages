@rem Run this script if you're using windows.

setlocal
@echo off

@rem Compile C code
clang -O3 c\code.c -o c\code
@rem Build Go code
go build -o go\code go\code.go
@rem Compile Java code
javac jvm\code.java
@rem Build Rust project with specific RUSTFLAGS and nightly toolchain
set RUSTFLAGS=-Zlocation-detail=none
cargo +nightly build --manifest-path rust\Cargo.toml --release
@rem Compile Kotlin code to a JAR file
kotlinc -include-runtime kotlin\code.kt -d kotlin\code.jar
@rem Compile Dart code for macOS
dart compile exe dart\code.dart -o dart\code --target-os=macos

endlocal
@rem End of line.
@rem DO NOT WRITE BEYOND HERE.