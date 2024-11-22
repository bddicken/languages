cdef const int fib(int n):
    if n == 0:
        return 0
    if n == 1:
        return 1
    return fib(n - 1) + fib(n - 2)

def fibonacci(int n) -> int:
    return fib(n)