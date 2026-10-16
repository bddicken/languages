import benchmark from "../../lib/goose";
import loops;

fn main() {
    let run_ms, warmup_ms, input = benchmark::arguments();
    let n, ok = parse_int(input);
    guard ok && n > 0 else { abort("the input must be a positive integer"); }
    let u = n as u32;
    var result: u32 = 0;
    fn work() -> u32 { loops(u) }
    fn keep(r: u32) { result = r; }
    benchmark::run(warmup_ms, work, keep);
    let stats = benchmark::run(run_ms, work, keep);
    print(benchmark::format_results(stats, result));
}
