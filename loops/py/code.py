import random
import sys


def optimized_computation(u):
    a = [0] * 10000  # Array of 10k elements initialized to 0
    r = random.randint(0, 10000)  # Get a random number 0 <= r < 10k

    for i in range(10000):  # 10k outer loop iterations
        total = 0
        for j in range(100000):  # 100k inner loop iterations, per outer loop iteration
            total += j % u
        a[i] = total + r
    return a[r]


if __name__ == "__main__":
    u = int(sys.argv[1])  # Get an input number from the command line
    result = optimized_computation(u)
    print(result)
