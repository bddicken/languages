use std::env;

use levenshtein::levenshtein_distance;

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();

    if args.len() < 2 {
        eprintln!("Please provide at least two strings as arguments.");
        std::process::exit(2);
    }

    if args.iter().any(|s| s.is_empty()) {
        eprintln!("This benchmark assumes non-empty strings.");
        std::process::exit(3);
    }

    // try different integer sizes (u32/u64/usize) to see their impact on performance
    let mut min_distance = u32::MAX;
    let mut times: usize = 0;

    // compare all pairs of strings
    for (i, s1) in args.iter().enumerate() {
        for (j, s2) in args.iter().enumerate() {
            if i == j {
                continue;
            }

            let distance = levenshtein_distance(s1, s2);
            min_distance = min_distance.min(distance);

            times += 1;
        }
    }

    println!("times: {times}");
    println!("min_distance: {min_distance}");
}
