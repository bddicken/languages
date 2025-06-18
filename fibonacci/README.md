# Fibonacci

This program should benchmark a function computing `fibonacci(n)` using naïve recursion.
* The code is supposed to have early return for `n < 2` (the base cases).
* For the non-base cases the code should do two recursive calls.
* The code should be free of any hints to the compiler to memoize, use tail recursion,
  iterative methods, or any avoidance of the naïve recursion.
* The program need not handle `n > 47` in a correct way. 

If some compiler finds ways to avoid recursive calls without any hints, than that is a result. We are in some sense testing compilers here, after all.

Reference implementations:
* Clojure: [run.clj](clojure/run.clj)
* Java: [run.java](jvm/run.java)
* C: [run.c](c/run.c)
