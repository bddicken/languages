import sys
import numpy as np

def main():
    u = int(sys.argv[1])

    # Generate Fibonacci numbers iteratively
    if u <= 1:
        print(0)
        return None

    fib = np.zeros(u, dtype=np.int64)  # Initialize array for Fibonacci numbers
    fib[1] = 1  # Set the first Fibonacci number

    for i in range(2, u):
        fib[i] = fib[i - 1] + fib[i - 2]

    # Sum the Fibonacci numbers
    r = np.sum(fib[1:])  # Exclude the 0th Fibonacci number for consistency
    print(r)
main()