import sys
import random
from numba import njit


@njit
def run(u, r):
    a = [0] * 10000                 # Array of 10,000 elements initialized to 0
    for i in range(10000):          # 10,000 outer loop iterations
        for j in range(100000):     # 100,000 inner loop iterations per outer loop iteration
            a[i] += j % u           # Simple sum
        a[i] += r                   # Add a random value to each element in array
    print(a[r])                     # Print out a single element from the array


u = int(sys.argv[1])                # Get an input number from the command line
r = random.randint(0, 9999)         # Get a random number 0 <= r < 10,000
run(u, r)
