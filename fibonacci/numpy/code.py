import sys
import numpy as np


def fibonacci(n, fib_array):
    # If the Fibonacci number has already been calculated, return it
    if fib_array[n] != -1:
        return fib_array[n]

    # Base cases
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        # Recursive computation
        fib_array[n] = fibonacci(n - 1, fib_array) + fibonacci(n - 2, fib_array)

    return fib_array[n]


def main():
    u = int(sys.argv[1])

    # Initialize a NumPy array with -1 (indicating uncomputed Fibonacci values)
    fib_array = np.full(u, -1, dtype=np.int64)

    # Calculate the sum of Fibonacci numbers from F(1) to F(u-1)
    r = 0
    for i in range(1, u):
        r += fibonacci(i, fib_array)

    print(r)


main()
