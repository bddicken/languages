import sys

import cython
import fib_f

u: cython.int = int(sys.argv[1])
r: cython.int = 0
i: cython.int
for i in range(u):
    r += fib_f.fibonacci(i)
print(r)
