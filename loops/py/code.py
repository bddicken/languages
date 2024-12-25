import sys
import numpy as np


def main():
    cnt = np.int32(sys.argv[1])
    u = np.int32(cnt)  # Get an input number from the command line
    r = np.random.randint(0, 10000, dtype=np.int32)  # Get a random number 0 <= r < 10k
    a = np.zeros(10000, dtype=np.int32)  # Array of 10k elements initialized to 0

    for i in np.arange(10000, dtype=np.int32):  # 10k outer loop iterations
        for j in np.arange(10000, dtype=np.int32):  # 100k inner loop iterations, per outer loop iteration
            a[i] += j % u  # Simple sum
        a[i] += r  # Add a random value to each element in array
    print(a[r])  # Print out a single element from the array


main()
