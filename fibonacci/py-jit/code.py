import sys
from numba import njit, int32


@njit
def fibonacci(n: int32) -> int32:
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fibonacci(n-1) + fibonacci(n-2)


@njit
def main(u: int32):

    r = 0
    for i in range(1, u):
        r += fibonacci(i)
    print(r)


if __name__ == "__main__":
    u = int32(sys.argv[1])
    main(u)
