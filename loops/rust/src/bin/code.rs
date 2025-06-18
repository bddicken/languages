use std::error::Error;

use loops::*;

const LOOPS_OUTER: usize = 10_000;
const LOOPS_INNER: usize = 100_000;

fn main() -> Result<(), Box<dyn Error>> {
    let args: Vec<String> = std::env::args().skip(1).collect();

    let divisor = args.first().ok_or("missing number argument")?.parse()?;

    // try different integer sizes for numbers N (u32/u64/u128/usize) and RNG (u16/u32/u64/u128/usize)
    let result = loops::<u32, u32, LOOPS_OUTER, LOOPS_INNER>(divisor);

    // print out a single element from the array
    println!("{}", result);

    Ok(())
}
