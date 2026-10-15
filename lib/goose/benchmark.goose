// The in-process runner of bddicken/languages, after its lib/c/benchmark.c:
// run the function under benchmark as many times as fit in a given number of
// milliseconds of measured time, timing each call on a monotonic nanosecond
// clock, and report the mean, standard deviation, minimum and maximum of
// those times and how many calls there were.
//
// Goose has no function pointers or closures that escape: the function under
// benchmark is a compile-time function argument, so each benchmark gets a
// runner of its own with the call made directly, as a template would in C++.

namespace benchmark;

import std;
import os;
import math;

struct Stats { mean_ms: f64, std_dev_ms: f64, min_ms: f64, max_ms: f64, runs: i64 }

// Calls W() as many times as fit in run_ms of measured time, and hands the
// result of the last call to K, outside the time measured. A run_ms of 0 runs
// nothing, and 1 is the check-output run, which prints no status dots.
fn run<W, K>(run_ms: i64) -> Stats {
    guard run_ms > 0 else { return Stats { .. }; }
    let run_ns = run_ms * 1000000;
    let dots = run_ms > 1;
    var elapsed: i64[>..] = [];
    var total = 0;
    if dots { write_stderr("."); }
    var last_status = clock_ns();
    while total < run_ns {
        let t0 = clock_ns();
        let result = W();
        let t1 = clock_ns();
        if dots && t0 - last_status > 1000000000 {
            last_status = t1;
            write_stderr(".");
        }
        total += t1 - t0;
        elapsed.push(t1 - t0);
        if total >= run_ns { K(result); }
    }
    if dots { write_stderr("\n"); }

    var sum = 0.0;
    for e in elapsed { sum += e / 1000000.0; }
    let mean = sum / elapsed.len;
    var squares = 0.0;
    var lo = elapsed[0];
    var hi = elapsed[0];
    for e in elapsed {
        let diff = e / 1000000.0 - mean;
        squares += diff * diff;
        lo = min(lo, e);
        hi = max(hi, e);
    }
    return Stats {
        mean_ms: mean,
        std_dev_ms: sqrt(squares / elapsed.len),
        min_ms: lo / 1000000.0,
        max_ms: hi / 1000000.0,
        runs: elapsed.len,
    };
}

// The line every program prints: mean_ms,std-dev-ms,min_ms,max_ms,runs,result.
fn format_results(stats: Stats, result: i64) -> u8[>..] {
    var out: u8[>..] = [];
    for v in [stats.mean_ms, stats.std_dev_ms, stats.min_ms, stats.max_ms] {
        format_flt(out, v, 6);
        out.push(',');
    }
    format(out, stats.runs, ",", result);
    return out;
}

// The three arguments every program takes: the run time and the warmup time
// in milliseconds, and the input.
fn arguments() -> i64, i64, const u8[:] {
    let a = args();
    if a.len != 4 {
        print("Usage: ", a[0], " <run_ms> <warmup_ms> <input>");
        exit(1);
    }
    let run_ms, ok1 = parse_int(a[1]);
    let warmup_ms, ok2 = parse_int(a[2]);
    if !ok1 || !ok2 {
        print("run_ms and warmup_ms must be integers");
        exit(1);
    }
    return run_ms, warmup_ms, a[3];
}
