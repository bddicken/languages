import sys
import numpy as np

def fibonacci(n):
    F = np.matrix([[1, 1], [1, 0]])
    if n == 0:
        return 0
    return (F ** (n - 1))[0, 0]

def main():
    u = int(sys.argv[1])
    r = 0
    for i in range(1, u):
        r += fibonacci(i)
    print(r)

main()
