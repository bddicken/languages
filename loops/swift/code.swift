func main() {
    let u = Int(CommandLine.arguments[1])!
    let r = Int.random(in: 0...9999)            // Get a random integer 0 <= r < 10k
    var a = [Int](repeating: 0, count: 10000)   // Array of 10k elements initialized to 0
    for i in 0..<10000 {                        // 10k outer loop iterations
        for j in 0..<100000 {                   // 100k inner loop iterations, per outer loop iteration
            a[i] += j % u                       // Simple sum
        }
        a[i] += r                               // Add a random value to each element in array
    }
    print(a[r])                                 // Print out a single element from the array
}

main()
