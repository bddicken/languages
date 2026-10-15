import benchmark from "../../lib/goose";
import fibonacci;

fn main() {
    let run_ms, warmup_ms, input = benchmark::arguments();
    let n, ok = parse_int(input);
    guard ok else { abort("the input must be an integer"); }
    let u = n as i32;
    var result = 0;
    fn work() -> i32 { fibonacci(u) }
    fn keep(r: i32) { result = r; }
    benchmark::run(warmup_ms, work, keep);
    let stats = benchmark::run(run_ms, work, keep);
    print(benchmark::format_results(stats, result));
}
