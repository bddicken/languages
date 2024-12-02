import std/[random, os, strutils]

# Get an input number from the command line
let u: uint32 = parseInt(paramStr(1)).uint32

# Get a random number 0 <= r < 10k
var r:uint32 = rand(10000).uint32

# Array of 10k elements initialized to 0
var a: seq[uint32]  = newSeq[uint32](10000)

# 10k outer loop iterations
for i in 0..9999:
    # 100k inner loop iterations, per outer loop iteration
    for j in 0..99999:
        # Simple sum
        a[i] = a[i] + j.uint32 mod u
    # Add a random value to each element in array
    a[i] = a[i] + r

# Print out a single element from the array
echo a[r]