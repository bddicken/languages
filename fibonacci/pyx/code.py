import sys

import cython


def fibonacci(n: cython.int) -> cython.int:
    a: cython.int = 0
    b: cython.int = 1
    for _ in range(n):
        a, b = b, b + a
        return a


u = int(sys.argv[1])
r = 0
for i in range(u):
    r += fibonacci(i)
print(r)
