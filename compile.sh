clang -O3 c/code.c -o c/code
go build -o go/code go/code.go
cargo build --release --manifest-path rust/Cargo.toml

