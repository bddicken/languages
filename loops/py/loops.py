import sys
import random


def loops(u: int) -> int:
    r = random.randint(0, 10000)  # Get a random number 0 <= r < 10k
    a = [0] * 10000  # Array of 10k elements initialized to 0
    for i in range(10000):  # 10k outer loop iterations
        for j in range(10000):  # 10k inner loop iterations, per outer loop iteration
            a[i] += j % u  # Simple sum
        a[i] += r  # Add a random value to each element in array
    return (a[r])  # Return a single element from the array
