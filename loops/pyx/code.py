from random import randint

import cython


@cython.cdivision(True)
def root_impl(u: cython.int) -> cython.int:
    r: cython.int = randint(0, 10000)

    i: cython.int
    j: cython.int

    a: cython.int[10000] = [0] * 10000
    for i in range(10000):
        for j in range(100000):
            a[i] += j % u
        a[i] += r
    print(a[r])
    print(a[r])
