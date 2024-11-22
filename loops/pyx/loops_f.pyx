from sys import argv
from random import randint

def test():
    pass

def loops():
    cdef int u = int(argv[1])
    cdef int r = randint(0, 10000)

    cdef int i, j

    cdef int[10000] a = [0] * 10000
    for i in range(10000):
        for j in range(100000):
            a[i] += j % u
        a[i] += r
    print(a[r])
