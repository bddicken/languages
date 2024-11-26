import sys
from itertools import cycle, islice
from random import randint


def main():
    u = int(sys.argv[1])  # Get an input number from the command line
    r = randint(0, 10000)  # Get a random number 0 <= r < 10k
    a = [0] * 10000  # Array of 10k elements initialized to 0
    # 10k outer loop iterations
    for i in range(len(a)):
        # 100k inner loop iterations, per outer loop iteration
        a[i] = sum(islice(cycle(range(u)), 100000))
        # Add a random value to each element in array
        a[i] += r

    print(a[r])  # Print out a single element from the array


if __name__ == "__main__":
    main()
