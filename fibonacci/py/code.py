import sys

def fibonacci(n):
  return n if n <= 1 else fibonacci(n-1) + fibonacci(n-2)

def main():
    u = int(sys.argv[1])
    r = 0
    for i in range(1, u):
      r += fibonacci(i)
    print(r)

main()
