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
        guard let u = Int(args.dropFirst(2).first!) else {
            print("Invalid input argument")
            exit(1)
        }

        // Warmup run (result ignored)
        _ = benchmarkRun(runMs: warmupMs) {
            return loops(u)
        }

        // Benchmark run: measure the loops function
        let stats = benchmarkRun(runMs: runMs) {
            return loops(u)
        }

        // Output CSV: mean_ms,std-dev-ms,min_ms,max_ms,runs,result
        print(String(format: "%.6f,%.6f,%.6f,%.6f,%d,%d",
                      stats.meanMs, stats.stdDevMs, stats.minMs, stats.maxMs, stats.runs, stats.result))
    }
}
