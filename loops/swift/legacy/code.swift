@main
struct Main {
    static func main() {
        let u = Int(CommandLine.arguments[1])!
        let r = Int.random(in: 0..<10000)

        withUnsafeTemporaryAllocation(of: Int.self, capacity: 10000) { a in
            a.initialize(repeating: 0)

            for i in 0..<10000 {
                for j in 0..<100000 {
                    a[i] += j % u
                }

                a[i] += r
            }

            print(a[r])
        }
    }
}
