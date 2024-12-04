import sys
from functools import lru_cache

@lru_cache(maxsize=None)
def fibonacci(n):
  if (n == 0):
    return 0
  if (n == 1):
    return 1
  return fibonacci(n-1) + fibonacci(n-2)

def main():
    u = 40 #int(sys.argv[1])
    r = 0
    for i in range(1, u):
      r += fibonacci(i)
    print(r)

main()
