import sys

def fibonacci(n):
  return fibonacci(n,0,1)

def fibonacci_accumulator(n,a,b):
    if (n == 0):
        return a
    return fibonacci_accumulator(n-1,b,a+b)

u = int(sys.argv[1])
r = 0
for i in range(u):
  r += fibonacci(i)
print(r)
