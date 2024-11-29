import os, random, strutils

# Get an input number from the command line
let u = paramStr(1).parseInt()

# Get a random number 0 <= r < 10,000
let r = rand(10000)

# Array of 10k elements initialized to 0
var a: array[10000, int]
for i in 0..<10000:
  a[i] = 0

# Outer loop: 10k iterations
for i in 0..<10000:
  # Inner loop: 100k iterations
  for j in 0..<100000:
    a[i] = a[i] + j mod u  # Simple sum
  a[i] = a[i] + r          # Add a random value to each element in the array

# Print out a single element from the array
echo a[r]