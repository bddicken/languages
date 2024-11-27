#!/bin/bash

# Get the directory where compile.sh is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Setup Python environment if needed
echo "Checking Python environment..."
if [ ! -d "$SCRIPT_DIR/venv" ]; then
    if [ ! -f "$SCRIPT_DIR/requirements.txt" ]; then
        echo "Error: requirements.txt not found in $SCRIPT_DIR"
        exit 1
    fi
    echo "Setting up Python virtual environment..."
    cd "$SCRIPT_DIR"
    python3 -m venv venv
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create virtual environment"
        exit 1
    fi
    echo "Installing Python requirements..."
    ./venv/bin/pip install -r requirements.txt
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install requirements"
        exit 1
    fi
    cd - > /dev/null
fi

echo -e "\nCompiling language implementations..."

# Compile other languages (only if tools are available)
if command -v clang >/dev/null 2>&1; then
    echo "Compiling C..."
    clang -O3 c/code.c -o c/code
fi

if command -v go >/dev/null 2>&1; then
    echo "Compiling Go..."
    go build -o go/code go/code.go
fi

if command -v javac >/dev/null 2>&1; then
    echo "Compiling Java..."
    javac jvm/code.java
fi

if command -v cargo >/dev/null 2>&1; then
    if rustup toolchain list | grep -q nightly; then
        echo "Compiling Rust..."
        RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release
    else
        echo "  Rust nightly toolchain not installed - skipping Rust compilation"
    fi
fi

if command -v kotlinc >/dev/null 2>&1; then
    echo "Compiling Kotlin..."
    kotlinc -include-runtime kotlin/code.kt -d kotlin/code.jar
else
    echo "  Kotlin not installed - skipping Kotlin compilation"
fi

if command -v dart >/dev/null 2>&1; then
    echo "Compiling Dart..."
    dart compile exe dart/code.dart -o dart/code --target-os=macos
else
    echo "  Dart not installed - skipping Dart compilation"
fi

echo -e "\n Compilation complete!"
