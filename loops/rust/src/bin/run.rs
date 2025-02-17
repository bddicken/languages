use std::error::Error;

use benchmark::{BenchmarkArguments, BenchmarkContext};
use loops::*;

const ITERATIONS: usize = 10_000;

fn main() -> Result<(), Box<dyn Error>> {
    // retrieve arguments for benchmark, contains program arguments
    let args: BenchmarkArguments = benchmark::load_arguments()?;

    if args.program_args.len() != 1 {
        eprintln!("Please provide a number as argument!");
        std::process::exit(2);
    }

    // parse program arguments
    let divisor = args.program_args[0].parse()?;

    // perform full benchmark
    // try different integer sizes for numbers N (u32/u64/u128/usize) and RNG (u16/u32/u64/u128/usize)
    let mut context =
        BenchmarkContext::new(move || loops::<u32, u32, ITERATIONS, ITERATIONS>(divisor));
    let stats = context
        .benchmark(args.run_ms, args.warmup_ms)
        .ok_or("no benchmark result")?;

    // get last result for success checks
    let last_result = stats.last_result().ok_or("empty result list")?;

    // output results
    stats.print_output(last_result);

    Ok(())
}
