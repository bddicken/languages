import sys


def fibonacci(n):
    if n < 2:
        return n
    return fibonacci(n-1) + fibonacci(n-2)


def main():
    u = int(sys.argv[1])
    r = 0
    for i in range(1, u):
        r += fibonacci(i)
    print(r)


main()
