import sys
import random


def sum_j_mod_u(N, u):
    # N mod u:
    L = N % u
    # Floor(N / u):
    m = N // u
    # sum_{k=0 to u-1} k = u*(u-1)//2
    # sum_{k=0 to L-1} k = L*(L-1)//2
    return m * (u*(u-1)//2) + (L*(L-1)//2)

def main():
    u = int(sys.argv[1])
    r = random.randint(0, 10000)
    total = sum_j_mod_u(100000, u) + r
    print(total)  # since a[r] == total

main()
