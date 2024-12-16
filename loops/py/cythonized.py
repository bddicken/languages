import sys
import random
import cython

# cython.boundscheck(False) disables bounds checking for array access
# cython.cdivision(True) disables validity checking for division by zero
# cython.locals() declares the types of variables as native
@cython.boundscheck(False)
@cython.cdivision(True)
@cython.locals(u=cython.int, r=cython.int, a=cython.int[10000], j=cython.int, i=cython.int)
def main():
    u = int(sys.argv[1])         # Get an input number from the command line
    r = random.randint(0, 10000) # Get a random number 0 <= r < 10k
    a  = [0] * 10000             # Array of 10k elements initialized to 0
    for i in range(10000):       # 10k outer loop iterations
      for j in range(100000):    # 100k inner loop iterations, per outer loop iteration
        a[i] += j % u            # Simple sum
      a[i] += r                  # Add a random value to each element in array
    print(a[r])                  # Print out a single element from the arra

if __name__ == '__main__':
    # force import of cythonized module
    from cythonized import main
    main()