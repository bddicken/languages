import sys
import random
import numpy as np

def main():
  u = int(sys.argv[1])         # Get an input number from the command line
  r = random.randint(0, 10000) # Get a random number 0 <= r < 10k
  a = np.zeros(10000, dtype=int) # Array of 10k elements initialized to 0
  for i in range(10000):       # 10k outer loop iterations
    a[i] = np.sum(np.arange(100000) % u) # Efficient sum using numpy
    a[i] += r                # Add a random value to each element in array
  print(a[r])                  # Print out a single element from the array

if __name__ == "__main__":
  main()
