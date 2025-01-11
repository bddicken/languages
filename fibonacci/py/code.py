import sys

def fibonacci_iterative(n):
    """Calculate the nth Fibonacci number iteratively."""
    if n == 0:
        return 0
    if n == 1:
        return 1

    a, b = 0, 1  # Initialize the first two Fibonacci numbers
    for _ in range(2, n + 1):
        a, b = b, a + b  # Update Fibonacci numbers
    return b

def main():
    u = int(sys.argv[1])  # Read input from command line
    r = 0

    # Calculate the sum of Fibonacci numbers from 1 to u-1
    for i in range(1, u):
        r += fibonacci_iterative(i)

    print(r)  # Print the result

if __name__ == "__main__":
    main()
