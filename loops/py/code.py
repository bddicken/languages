import sys
import random

def main():
    u = int(sys.argv[1])  # Get an input number from the command line
    r = random.randint(0, 10000)  # Get a random number 0 <= r < 10k

    # Compute the sum of modulos directly to avoid the inner loop
    sum_modulo = sum(j % u for j in range(100000))

    # Create an array of 10,000 elements, all initialized to sum_modulo + r
    a = [sum_modulo + r] * 10000

    # Print the value at the randomly chosen index
    print(a[r])

if __name__ == "__main__":
    main()
