func fibonacci(_ n: Int) -> Int {
    if n == 0 { return 0 }
    if n == 1 { return 1 }
    return fibonacci(n - 1) + fibonacci(n - 2)
}

let u = Int(CommandLine.arguments[1])!
var r = 0

for i in 1..<u {
    r += fibonacci(i)
}

print(r)
