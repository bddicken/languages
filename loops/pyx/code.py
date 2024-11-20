from random import randint
from sys import argv

import cython


@cython.cdivision(True)
def root_impl() -> cython.int:
    u: cython.int = argv[1]
    r: cython.int = randint(0, 10000)

    i: cython.int
    j: cython.int

    a: cython.int[10000] = [0] * 10000
    for i in range(10000):
        for j in range(100000):
            a[i] += j % u
        a[i] += r
    print(a[r])
