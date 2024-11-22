# C
clang -O3 c/code.c -o c/code

# Go
go build -o go/code go/code.go

# Cython
python3 -m pip install cython setuptools
python3 pyx/setup.py build_ext --inplace 
mv *.cpython* build pyx/ -f

# Java
javac jvm/code.java

# Rust
# RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release 