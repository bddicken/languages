import sys

def fibonacci(n):
  if (n == 0):
    return 0
  if (n == 1):
    return 1
  return fibonacci(n-1) + fibonacci(n-2)

u = int(sys.argv[1])
r = sum(fibonacci(i) for i in range(u))
print(r)
