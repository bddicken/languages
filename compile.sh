# C
clang -O3 c/code.c -o c/code

# Go
go build -o go/code go/code.go

# Cython
python3 -m pip install cython setuptools
python3 pyx/setup.py build_ext --inplace 
mv code.cpython* build pyx/ -f