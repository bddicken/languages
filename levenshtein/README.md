# Levenshtein

This program aims to benchmark implementations of a function for [levenshtein distances](https://en.wikipedia.org/wiki/Levenshtein_distance). All implementations must use the [Wagner-Fischer algorithm](https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm), with a few of the performance enhancements:

- Reduced space complexity from O(m*n) to O(min(m,n)) by using only two rows instead of building full matrix
- Always use the shorter string for column dimension to minimize space usage
- Reuse arrays instead of creating new ones

The benchmark involves two functions:

1. The **distance** function, this is the one we are interested in benchmarking (where Wagner-Fisher is applied)
   * It should take two strings as its arguments, return the distance
   * It should not use pre-allocated memory
3. The **distances** function, used to run the **distance** function with some variation of string lengths and content (mostly random gibberish)
   * It should take a list of strings as its argument and return a list distances of all pairings of the strings
   * To minimize the impact of it on the benchmark, this function should be made as efficient as possible, pulling from the toolbox of the language implementing it 
    
The strings (words) are provided from a file given as the `input` argument to the program. There is one word per line in the file.

The progtram should benchmark/measure the **distances** function using the words provided, and then, outside the measured time, sum these distances and report the sum as the result. 

The code should follow the reference implementations as closely as possible:

* Clojure: [run.clj](clojure/run.clj)
* Java: [run.java](jvm/run.java)
* C: [run.c](c/run.c)
