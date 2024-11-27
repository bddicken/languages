import Foundation

func fibonacci(n: Int) -> Int {
    if n < 2 {
        return n
    } else {
        return fibonacci(n: n-1) + fibonacci(n: n-2)
    }
}

func main() {
    let u   = Int(CommandLine.arguments[1])!
    var sum = 0
    for i in 1..<u {
        sum += fibonacci(n: i)
    }
    print(sum)
}

main()
