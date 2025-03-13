import random
import sys


def main():
    u = int(sys.argv[1])  # Get an input number from the command line
    r = random.randint(0, 10000)  # Get a random number 0 <= r < 10k
    a = [sum([j % u for j in range(100_000)]) + r for _ in range(10_000)]
    print(a[r])  # Print out a single element from the array


main()
