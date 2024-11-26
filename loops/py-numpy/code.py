import sys
import numpy as np

u = int(sys.argv[1])                        # Get input number from command line
r = np.random.randint(0, 10_000)            # random number 0 <= r < 10k
a = np.zeros(10_000, dtype=int)             # Array of 10k elements initialized to 0
for i in range(10_000):                     # 10k outer loop iterations
    a[i] += np.sum(np.arange(100_000) % u)  # inner loop(s) in numpy kernels
a += r                                      # loop in numpy again
print(a[r])                                 # Print out a single element from array
