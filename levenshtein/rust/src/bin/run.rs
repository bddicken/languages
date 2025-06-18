use std::error::Error;

use benchmark::{BenchmarkArguments, BenchmarkContext};
use levenshtein::*;

fn calculate_distances<T: CostInteger>(word_list: &[String]) -> Result<Vec<T>, &'static str> {
    let list_length = word_list.len();
    let mut results = Vec::with_capacity((list_length * (list_length - 1)) / 2);

    // take over first words up to the penultimate element
    for (i, word_a) in word_list.iter().take(list_length - 1).enumerate() {
        // rest of words in list for comparison
        let (_, cmp_words) = word_list.split_at(i + 1);

        for word_b in cmp_words.iter() {
            let distance = levenshtein_distance(word_a, word_b);
            results.push(distance);
        }
    }

    Ok(results)
}

fn main() -> Result<(), Box<dyn Error>> {
    // retrieve arguments for benchmark, contains program arguments
    let args: BenchmarkArguments = benchmark::load_arguments()?;

    if args.program_args.len() != 1 {
        eprintln!("Please provide an input file as argument!");
        std::process::exit(2);
    }

    // parse program arguments
    let input_file: String = args.program_args[0].to_string();

    let word_list: Vec<String> = benchmark::file_read_lines(&input_file)?;

    if word_list.iter().any(|string| string.is_empty()) {
        eprintln!("This benchmark assumes non-empty strings!");
        std::process::exit(3);
    }

    // perform full benchmark
    // try different integer sizes (u32/u64/usize) to see their impact on performance
    let mut context = BenchmarkContext::new(move || calculate_distances::<u32>(&word_list));
    let stats = context
        .benchmark(args.run_ms, args.warmup_ms)
        .ok_or("no benchmark result")?;

    // get last result for success checks
    let last_result = stats
        .last_result()
        .ok_or("empty result list")?
        .as_ref()
        .map_err(|&msg| msg)?;

    // sum the list of distances outside the benchmarked function
    // (fold can infer the typy automatically, sum needs explicit type annotations)
    #[allow(clippy::unnecessary_fold)]
    let sum = last_result.iter().fold(0, |acc, n| acc + n);

    // output results
    stats.print_output(sum);

    Ok(())
}
