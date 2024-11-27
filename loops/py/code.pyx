import sys
import random
cimport cython
from libc.stdlib cimport malloc, free

@cython.boundscheck(False)  # Disable bounds checking for performance
@cython.wraparound(False)    # Disable wraparound for performance
def main(int u):
    cdef int r = random.randint(0, 10000)  # Get a random number 0 <= r < 10k
    cdef int* a = <int*>malloc(10000 * sizeof(int))  # Allocate memory for the array
    cdef int i, j

    # Initialize the array to zero
    for i in range(10000):
        a[i] = 0  # Set each element to 0

    for i in range(10000):                   # 10k outer loop iterations
        for j in range(100000):              # 100k inner loop iterations, per outer loop iteration
            a[i] += j % u                    # Simple sum
        a[i] += r                            # Add a random value to each element in array

    print(a[r])                              # Print out a single element from the array 

    free(a)                                  # Free the allocated memory