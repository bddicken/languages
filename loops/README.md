# Loops

This program should benchmark a function that makes 100 milion updates to an array,
with some super simple math in each iteration. The code is designed to try force
the compiler to generate code that actually makes 100 million updates. The code
should be free of any hints to the compiler that the loops actually can be fully
unrolled. If some compiler or interpreter still finds ways to unroll the loops,
then that will be considered a valid result.

The code should follow the reference implementations as closely as possible:

* Clojure: [run.clj](clojure/run.clj)
* Java: [run.java](jvm/run.java)
* C: [run.c](c/run.c)

Note: Like with the reference implementations the innermost sum should be assigned
directly to the array index.