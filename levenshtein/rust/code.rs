use std::env;

/// Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
/// Space Complexity: O(min(m,n)) - only uses two rows instead of full matrix
/// Time Complexity: O(m*n) where m and n are the lengths of the input strings
fn levenshtein_distance(s1: &str, s2: &str) -> usize {
    // Early termination checks
    if s1 == s2 {
        return 0;
    } else if s1.is_empty() {
        return s2.len();
    } else if s2.is_empty() {
        return s1.len();
    }

    // Correctness checks
    assert!(s1.len().max(s2.len()) < u32::MAX as usize / 2);
    assert!(s1.is_ascii() && s2.is_ascii());

    // Convert to bytes for faster access
    // And make s1 the shorter string for space optimization
    let (s1, s2) = match s1.len() < s2.len() {
        true => (s1.as_bytes(), s2.as_bytes()),
        false => (s2.as_bytes(), s1.as_bytes()),
    };

    // Use two rows instead of full matrix for space optimization
    let mut prev_row: Vec<_> = (0..=s1.len() as _).collect();
    let mut curr_row = vec![0u32; s1.len() + 1];

    // Main computation loop
    for (j, &ch2) in s2.iter().enumerate() {
        curr_row[0] = (j + 1) as _;

        // Iterate on 2-sized windows of curr_row and prev_row to remove out-of-bounds checks
        let mut curr_window0 = curr_row[0];
        for (&ch1, (curr_window1, prev_window)) in
            (s1.iter()).zip(curr_row[1..].iter_mut().zip(prev_row.windows(2)))
        {
            let cost = (ch1 != ch2) as u32;

            // Calculate minimum of three operations
            *curr_window1 = (prev_window[1] + 1) // deletion
                .min(curr_window0 + 1) // insertion
                .min(prev_window[0] + cost); // substitution
            curr_window0 = *curr_window1;
        }

        // Swap rows
        (prev_row, curr_row) = (curr_row, prev_row);
    }

    *prev_row.last().unwrap() as _
}

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();

    if args.len() < 2 {
        println!("Please provide at least two strings as arguments.");
        return;
    }

    let mut min_distance = usize::MAX;
    let mut times = 0;

    // Compare all pairs of strings
    for (i, arg0) in args.iter().enumerate() {
        for (j, arg1) in args.iter().enumerate() {
            if i == j {
                continue;
            }
            let distance = levenshtein_distance(arg0, arg1);
            min_distance = min_distance.min(distance);
            times += 1;
        }
    }

    println!("times: {times}");
    println!("min_distance: {min_distance}");
}
