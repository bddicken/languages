import sys
import random
import numpy as np

def main():
    u = int(sys.argv[1]) # Get an input number from the command line
    r = random.randint(0, 10000) # Get a random number 0 <= r < 10k

    # Use Python integers to avoid overflow issues
    mod_array = np.arange(100000, dtype=object) % u  # Compute j % u for j in range(100000)
    inner_sum = np.sum(mod_array)  # Sum the values using Python's arbitrary-precision integers

    # Initialize a NumPy array and calculate each value
    a = np.full(10000, inner_sum, dtype=object)  # Start with the inner sum
    a += r  # Add the random number `r` to all elements

    print(a[r]) # Print out a single element from the arra
main()