import sys
from numba import njit, int32

@njit
def fibonacci(n: int32) -> int32:
    if n < 2:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
