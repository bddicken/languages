clang -O3 c/code.c -o c/code
go build -o go/code go/code.go
javac jvm/code.java
RUSTFLAGS="-Zlocation-detail=none" cargo +nightly build --manifest-path rust/Cargo.toml --release
kotlinc -include-runtime kotlin/code.kt -d kotlin/code.jar
#kotlinc-native -include-runtime kotlin/code.kt -d kotlin/code
dart compile exe dart/code.dart -o dart/code --target-os=macos
python3 -m pip install --upgrade pip && python3 -m pip install numba
python3 -m pip install pip setuptools --upgrade && \ 
python3 -m pip install virtualenv && \
python3 -m virtualenv py/.venv && \
source py/.venv/bin/activate && \ 
python3 -m pip install -r py/requirements.txt && \
pypy3 -m pip install cython
pypy3 ./py/setup.py build_ext --inplace