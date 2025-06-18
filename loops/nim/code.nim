import std/[random, os, strutils]

let 
    # Get an input number from the command line
    u: uint32 = parseInt(paramStr(1)).uint32

    # Get a random number 0 <= r < 10k
    r:uint32 = rand(10000).uint32

# Array of 10k elements initialized to 0
var a: array[10000, uint32] 

# 10k outer loop iterations
for i in 0..9999:
    # 100k inner loop iterations, per outer loop iteration
    for j in 0..99999.uint32:
        # Simple sum
        a[i] = a[i] + j mod u
    # Add a random value to each element in array
    a[i] = a[i] + r

# Print out a single element from the array
echo a[r]