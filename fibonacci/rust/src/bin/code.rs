use std::error::Error;

use fibonacci::*;

fn main() -> Result<(), Box<dyn Error>> {
    let args: Vec<String> = std::env::args().skip(1).collect();

    // try different integer sizes (u32/u64/u128/usize) to see their impact on performance (u8/u16 are too small)
    let runs: u32 = args.first().ok_or("missing number argument")?.parse()?;

    // sum the fibonacci numbers
    // (fold can infer the type automatically, sum needs explicit type annotations)
    #[allow(clippy::unnecessary_fold)]
    let sum = (0..runs).map(fibonacci).fold(0, |acc, n| acc + n);

    println!("{}", sum);

    Ok(())
}
