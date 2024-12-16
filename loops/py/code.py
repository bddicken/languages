from functools import cache
import sys
import random

@cache
def compute(a, u, r):
    # memoized function - don't recompute if the same values are passed
    for j in range(100000): # 100k inner loop iterations, per outer loop iteration (for same values a, u, r)
        a += j % u          # Simple sum
    return a + r            # Add a random value to each element in array

def main():
    u = int(sys.argv[1])         # Get an input number from the command line
    r = random.randint(0, 10000) # Get a random number 0 <= r < 10k
    a = [0] * 10000              # Create an array of 10k elements
    # 10k outer loop iterations, in parallel and memoized
    tasks = ((a[i], u, r) for i in range(10000))
    a = list(parallel(compute, tasks))
    print(a[r])                  # Print out a single element from the arra

def parallel(fn, iterable):
    # helper for parallel processing as a transparent fallback in case memoization is not effective
    from multiprocessing import Pool
    with Pool() as p:
        return p.starmap(fn, iterable)

if __name__ == '__main__':
    main()
