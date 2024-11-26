open System

[<EntryPoint>]
let main args =
    let u = int args.[0] // Get an input number from the command line
    let random = Random()
    let r = random.Next(0, 10000) // Get a random integer 0 <= r < 10k
    let a = Array.zeroCreate<int> 10000 // Array of 10k elements initialized to 0
    for i in 0 .. 9999 do // 10k outer loop iterations
        for j in 0 .. 99999 do // 100k inner loop iterations, per outer loop iteration
            a.[i] <- a.[i] + j % u // Simple sum
        a.[i] <- a.[i] + r // Add a random value to each element in array
    printfn "%d" a.[r] // Print out a single element from the array
    0 // Return exit code
