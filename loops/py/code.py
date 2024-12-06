import sys
import random
import numpy as np

def main():
    u = int(sys.argv[1])         # Get an input number from the command line
    r = random.randint(0, 10000) # Get a random number 0 <= r < 10k

    # Create an array of indices for the modulo operation
    j_values = np.arange(100000) % u  # Vectorized modulo operation

    # Compute the sum for all elements in the array (broadcasted sum)
    sum_j = j_values.sum()  # Efficient sum using NumPy

    # Create the array of 10k elements initialized to sum_j
    a = np.full(10000, sum_j, dtype=np.int64)

    # Add the random value to each element in the array
    a += r

    # Print the specific element
    print(a[r])

if __name__ == "__main__":
    main()
