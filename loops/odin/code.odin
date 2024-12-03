package main

import "core:fmt"
import "core:strconv"
import "core:os"
import "core:math/rand"

main :: proc() {
    u := strconv.atoi(os.args[1]) // Get an input number from the command line
    r := rand.int_max(10000)      // Get a random number 0 <= r < 10k
    a := [10000]int{}             // Array of 10k elements initialized to 0

    for i in 0..<10000 {         // 10k outer loop iterations
        for j in 0..<100000 {     // 100k inner loop iterations, per outer loop iteration
            a[i] += j % u         // Simple sum
        }
        a[i] += r                 // Add a random value to each element in array
    }

    fmt.println(a[r])             // Print out a single element from the array
}
