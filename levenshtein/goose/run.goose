import benchmark from "../../lib/goose";
import os;
import levenshtein;

fn main() {
    let run_ms, warmup_ms, input = benchmark::arguments();
    // The words are slices of the file's text, one per line.
    var text: u8[>..] = [];
    guard read_file(input, text) else { abort(str("could not open file: ", input)); }
    var words: const u8[:][>..] = [];
    each_split(text, '\n') { if it.len > 0 { words.push(it); } };
    var sum = 0;
    fn work() -> u32[>..] { distances(words) }
    // The sum of the distances, outside the time measured.
    fn keep(d: u32[:]) {
        sum = 0;
        for x in d { sum += x; }
    }
    benchmark::run(warmup_ms, work, keep);
    let stats = benchmark::run(run_ms, work, keep);
    print(benchmark::format_results(stats, sum));
}
