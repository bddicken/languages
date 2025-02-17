import Foundation

@main
struct Main {
    static func main() {
        let args = CommandLine.arguments.dropFirst()
        guard args.count >= 3 else {
            print("Usage: <run_ms> <warmup_ms> <input_file>")
            exit(1)
        }
        guard let runMs = Int(args.first!),
              let warmupMs = Int(args.dropFirst().first!) else {
            print("Invalid time arguments")
            exit(1)
        }
        let inputFile = args.dropFirst(2).first!
        guard let content = try? String(contentsOfFile: inputFile, encoding: .utf8) else {
            print("Failed to read file: \(inputFile)")
            exit(1)
        }
        let words = content.split(separator: "\n").map { String($0) }

        // Warmup run (result ignored)
        _ = benchmarkRun(runMs: warmupMs) {
            return distances(words)
        }

        // Benchmark run: measure the distances function
        let stats = benchmarkRun(runMs: runMs) {
            return distances(words)
        }

        // Sum up distances outside the benchmark loop for correctness check
        let sum = (stats.result as [Int]).reduce(0, +)
        // Output CSV: mean_ms,std-dev-ms,min_ms,max_ms,runs,result
        print(String(format: "%.6f,%.6f,%.6f,%.6f,%d,%d",
                      stats.meanMs, stats.stdDevMs, stats.minMs, stats.maxMs, stats.runs, sum))
    }
}
