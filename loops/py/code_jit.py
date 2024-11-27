from numba import njit, prange
import sys
import random


@njit(fastmath=True, nogil=True, parallel=True)  # Enable parallel execution
def main(u, r):
    a = [0] * 10000                # Array of 10k elements initialized to 0
    for i in prange(10000):        # Use prange for parallel execution of outer loop
        sum_j = 0                  # Initialize sum for each outer loop iteration
        for j in range(100000):    # 100k inner loop iterations
            sum_j += j % u         # Accumulate the sum directly
        a[i] += sum_j + r          # Add the accumulated sum and r to each element
    return a[r]                    # Return a single element from the array

if __name__ == "__main__":
    u = int(sys.argv[1])           # Get an input number from the command line
    r = random.randint(0, 10000)    # Generate random number once
    print(main(u, r))               # Call the main function and print the result