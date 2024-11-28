// Get an input number from the command line
let u = Int(CommandLine.arguments[1])!

// Get a random number 0 <= r < 10k
let r = Int.random(in: 0..<10_000)

// Initialize a results array of 10k elements initialized to 0
var a = [Int](repeating: 0, count: 10_000)

// 10k outer loop iterations
for i in 0..<10_000 {
  // 100k inner loop iterations, per outer loop iteration
  for j in 0..<100_000 {
    a[i] += j % u // Compute a simple sum
  }
  a[i] += r // Add the random value to each element in array
}

// Print out a single element from the array
print(a[r])
