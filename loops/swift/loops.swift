public func loops(_ u: Int) -> Int {
    let r = Int.random(in: 0..<10000)

    return withUnsafeTemporaryAllocation(of: Int.self, capacity: 10000) { a in
        a.initialize(repeating: 0)

        for i in 0..<10000 {
            for j in 0..<10000 {
                a[i] += j % u
            }

            a[i] += r
        }

        return a[r];
    }
}
