use std::error::Error;

use benchmark::{BenchmarkArguments, BenchmarkContext};
use fibonacci::*;

fn main() -> Result<(), Box<dyn Error>> {
    // retrieve arguments for benchmark, contains program arguments
    let args: BenchmarkArguments = benchmark::load_arguments()?;

    if args.program_args.len() != 1 {
        eprintln!("Please provide a number as argument!");
        std::process::exit(2);
    }

    // parse program arguments
    // try different integer sizes (u32/u64/u128/usize) to see their impact on performance (u8/u16 are too small)
    let number: u32 = args.program_args[0].parse()?;

    // perform full benchmark
    let mut context = BenchmarkContext::new(move || fibonacci(number));
    let stats = context
        .benchmark(args.run_ms, args.warmup_ms)
        .ok_or("no benchmark result")?;

    // get last result for success checks
    let last_result = stats.last_result().ok_or("empty result list")?;

    // output results
    stats.print_output(last_result);

    Ok(())
}
