import sys
import random
u = int(sys.argv[1])         # Get an input number from the command line
r = random.randint(0, 10000) # Get a random number 0 <= r < 10k
a  = [0] * 10000             # Array of 10k elements initialized to 0
# 10k outer loop iterations, 100k inner loop iterations
a = [sum(j % u for j in range(100000)) + r for i in range(10000)]
print(a[r])                  # Print out a single element from the arra
