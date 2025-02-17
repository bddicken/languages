import Foundation

public struct BenchmarkResult<T> {
    public let meanMs: Double
    public let stdDevMs: Double
    public let minMs: Double
    public let maxMs: Double
    public let runs: Int
    public let result: T

    public init(meanMs: Double, stdDevMs: Double, minMs: Double, maxMs: Double, runs: Int, result: T) {
        self.meanMs = meanMs
        self.stdDevMs = stdDevMs
        self.minMs = minMs
        self.maxMs = maxMs
        self.runs = runs
        self.result = result
    }
}

public func benchmarkRun<T>(runMs: Int, f: () -> T) -> BenchmarkResult<T> {
    var elapsedTimes: [Double] = []
    var totalElapsed: UInt64 = 0
    var lastResult = f()
    let runNs = UInt64(runMs) * 1_000_000

    var lastStatusT = DispatchTime.now().uptimeNanoseconds
    if runMs > 1 {
        // Print initial status dot
        if let data = ".".data(using: .utf8) {
            FileHandle.standardError.write(data)
        }
        fflush(stderr)
    }

    while totalElapsed < runNs {
        let t0 = DispatchTime.now().uptimeNanoseconds
        lastResult = f()
        let t1 = DispatchTime.now().uptimeNanoseconds
        let elapsed = t1 - t0
        totalElapsed += elapsed
        elapsedTimes.append(Double(elapsed) / 1_000_000.0)
        if runMs > 1, t0 - lastStatusT > 1_000_000_000 {
            lastStatusT = t1
            if let data = ".".data(using: .utf8) {
                FileHandle.standardError.write(data)
            }
            fflush(stderr)
        }
    }
    if runMs > 1 {
        // Print newline after status dots
        if let data = "\n".data(using: .utf8) {
            FileHandle.standardError.write(data)
        }
        fflush(stderr)
    }

    let runs = elapsedTimes.count
    let mean = elapsedTimes.reduce(0, +) / Double(runs)
    let variance = elapsedTimes.map { pow($0 - mean, 2) }.reduce(0, +) / Double(runs)
    let stdDev = sqrt(variance)
    let minMs = elapsedTimes.min() ?? 0
    let maxMs = elapsedTimes.max() ?? 0
    return BenchmarkResult(meanMs: mean, stdDevMs: stdDev, minMs: minMs, maxMs: maxMs, runs: runs, result: lastResult)
}
