import sys
import random

def main():
  u = int(sys.argv[1])                     # Get an input number from the command line
  r = random.randint(0, 10000)             # Get a random number 0 <= r < 10k
  a = [                                    # make a list of 10k ints
    sum([j%u for j in range(100000)])      # sum of 100k ints mod u
    + r                                    # plus a random number
    for i in range(10000)                  # 10k times in the outer loop
  ]
  print(a[r])                              # Print out a single element from the list

main()