import Foundation

let u = Int(CommandLine.arguments[1])!  // Get input number from command line
let r = Int.random(in: 0..<10000)  // Get random number 0 <= r < 10k
var a = Array(repeating: 0, count: 10000)  // Array of 10k elements initialized to 0

for i in 0..<10000 {  // 10k outer loop iterations
    for j in 0..<100000 {  // 100k inner loop iterations
        a[i] = a[i] + j % u  // Simple sum
    }
    a[i] += r  // Add random value to each element
}

print(a[r])  // Print single element from array
