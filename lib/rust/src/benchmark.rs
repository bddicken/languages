use std::{
    env,
    fmt::Display,
    fs::File,
    io::{self, BufRead, BufReader},
    num::ParseIntError,
    path::Path,
    time::{Duration, Instant},
};

const NANOS_PER_MILLI: f64 = 1_000_000f64;
const INITIAL_RESULT_CAPACITY: usize = 1_000;

#[derive(Debug, Default)]
pub struct BenchmarkArguments {
    pub run_ms: u64,
    pub warmup_ms: u64,
    pub program_args: Vec<String>,
}

#[derive(Debug, Default)]
pub struct TimedResult<T> {
    #[allow(dead_code)]
    pub elapsed_total: Duration,
    pub elapsed: Duration,
    pub value: T,
}

#[derive(Debug, Default)]
pub struct BenchmarkResult<T> {
    pub mean: Duration,
    pub std_dev: Duration,
    pub min: Duration,
    pub max: Duration,
    pub results: Vec<TimedResult<T>>,
}

impl<T> BenchmarkResult<T> {
    pub fn runs(&self) -> usize {
        self.results.len()
    }

    pub fn last_result(&self) -> Option<&T> {
        Some(&self.results.last()?.value)
    }

    pub fn format_output(&self, check_value: impl Display) -> String {
        format!(
            "{:.6},{:.6},{:.6},{:.6},{},{}",
            (self.mean.as_nanos() as f64 / NANOS_PER_MILLI),
            (self.std_dev.as_nanos() as f64 / NANOS_PER_MILLI),
            (self.min.as_nanos() as f64 / NANOS_PER_MILLI),
            (self.max.as_nanos() as f64 / NANOS_PER_MILLI),
            self.runs(),
            check_value
        )
    }

    pub fn print_output(&self, check_value: impl Display) {
        let formatted_output = self.format_output(check_value);
        println!("{}\n", formatted_output);
    }
}

pub struct BenchmarkContext<T> {
    benchmark_fn: Box<dyn FnMut() -> T + 'static>,
}

/// Type T must be the return value of the benchmarked function.
impl<T> BenchmarkContext<T> {
    /// Create a new benchmark context with a closure to benchmark.
    pub fn new(benchmark_fn: impl FnMut() -> T + 'static) -> Self {
        Self {
            benchmark_fn: Box::new(benchmark_fn),
        }
    }

    /// run_ms:
    ///   0: don't run
    ///   1: check-output run
    pub fn run(&mut self, run_ms: u64) -> Option<BenchmarkResult<T>> {
        let mut benchmark_results: Vec<TimedResult<T>> =
            Vec::with_capacity(INITIAL_RESULT_CAPACITY);

        if run_ms == 0 {
            return None;
        } else if run_ms > 1 {
            // start with a status dot, but not if this is a check-output run
            eprint!(".");
        }

        let run_duration = Duration::from_millis(run_ms);

        let mut elapsed_total = Duration::ZERO;
        let mut last_time = Instant::now();

        while elapsed_total < run_duration {
            let time_start = Instant::now();

            let current_value: T = (self.benchmark_fn)();

            let time_end = Instant::now();

            // print status dots every second if it isn't a check-output run
            if run_ms > 1 && time_start.duration_since(last_time) > Duration::from_secs(1) {
                last_time = time_end;
                eprint!(".");
            }

            let elapsed = time_end.duration_since(time_start);
            elapsed_total = elapsed_total.saturating_add(elapsed);

            benchmark_results.push(TimedResult::<T> {
                elapsed_total,
                elapsed,
                value: current_value,
            });
        }

        // add newline for non check-output runs
        if run_ms > 1 {
            eprintln!();
        }

        // calculate timings after completing the run
        // (no unnecessary work during benchmark loop)
        let min: Duration = self.min(&benchmark_results)?;
        let max: Duration = self.max(&benchmark_results)?;
        let mean: Duration = self.mean(&benchmark_results)?;
        let std_dev: Duration = self.standard_deviation(&benchmark_results, mean)?;

        Some(BenchmarkResult::<T> {
            mean,
            std_dev,
            min,
            max,
            results: benchmark_results,
        })
    }

    pub fn benchmark(&mut self, run_ms: u64, warmup_ms: u64) -> Option<BenchmarkResult<T>> {
        // perform warmup runs
        self.run(warmup_ms);

        // perform benchmark runs
        self.run(run_ms)
    }

    fn min(&mut self, results: &[TimedResult<T>]) -> Option<Duration> {
        results.iter().map(|result| result.elapsed).min()
    }

    fn max(&mut self, results: &[TimedResult<T>]) -> Option<Duration> {
        results.iter().map(|result| result.elapsed).max()
    }

    fn mean(&mut self, results: &[TimedResult<T>]) -> Option<Duration> {
        if results.is_empty() {
            return None;
        }

        // needed as u32 for checked_div
        let results_length = u32::try_from(results.len()).ok()?;

        results
            .iter()
            .map(|result| result.elapsed)
            .sum::<Duration>()
            .checked_div(results_length)
    }

    fn standard_deviation(
        &mut self,
        results: &[TimedResult<T>],
        mean: Duration,
    ) -> Option<Duration> {
        if results.is_empty() {
            return None;
        }

        let diffs = results.iter().map(|result| result.elapsed.abs_diff(mean));
        let sum_squared_diffs = diffs
            .map(|diff| diff.as_nanos() * diff.as_nanos())
            .sum::<u128>();
        let std_dev = ((sum_squared_diffs as f64) / (results.len() as f64)).sqrt();

        Some(Duration::from_nanos(std_dev as u64))
    }
}

// Helper Functions

pub fn load_arguments() -> Result<BenchmarkArguments, ParseIntError> {
    let args_cli: Vec<String> = env::args().collect();

    if args_cli.len() < 3 {
        eprintln!(
            "Usage: {} <run_ms> <warmup_ms> ...<program args>",
            args_cli[0]
        );
        std::process::exit(1);
    }

    let (bench_args, program_args) = args_cli.split_at(3);

    let run_ms: u64 = bench_args[1].parse()?;
    let warmup_ms: u64 = bench_args[2].parse()?;

    Ok(BenchmarkArguments {
        run_ms,
        warmup_ms,
        program_args: program_args.iter().map(String::from).collect(),
    })
}

#[allow(dead_code)]
pub fn file_read_lines(file_path: impl AsRef<Path>) -> io::Result<Vec<String>> {
    let file = File::open(file_path)?;
    let buffered_reader = BufReader::new(file);

    buffered_reader.lines().collect()
}
