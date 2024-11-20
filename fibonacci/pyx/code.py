import sys

import cython


def fibonacci(n: cython.int) -> cython.int:
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fibonacci(n - 1) + fibonacci(n - 2)


u: cython.int = int(sys.argv[1])
r: cython.int = 0
i: cython.int
for i in range(u):
    r += fibonacci(i)
print(r)
