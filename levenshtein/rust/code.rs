use std::env;

/// Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
/// Space Complexity: O(min(m,n)) - only uses two rows instead of full matrix
/// Time Complexity: O(m*n) where m and n are the lengths of the input strings
fn levenshtein_distance(s1: &str, s2: &str) -> usize {
    // Early termination checks
    if s1 == s2 {
        return 0;
    }
    if s1.is_empty() {
        return s2.len();
    }
    if s2.is_empty() {
        return s1.len();
    }

    // Convert to bytes for faster access
    let s1_bytes = s1.as_bytes();
    let s2_bytes = s2.as_bytes();

    // Make s1 the shorter string for space optimization
    let (s1_bytes, s2_bytes) = if s1_bytes.len() > s2_bytes.len() {
        (s2_bytes, s1_bytes)
    } else {
        (s1_bytes, s2_bytes)
    };

    let m = s1_bytes.len();

    // Use two rows instead of full matrix for space optimization
    let mut prev_row: Vec<usize> = (0..=m).collect();
    let mut curr_row = vec![0; m+1];
    
    // Main computation loop
    for (j, b2) in s2_bytes.iter().enumerate() {
        curr_row[0] = j+1;

        for (i, b1) in s1_bytes.iter().enumerate() {
            let cost = if b1 == b2 { 0 } else { 1 };
            
            // Calculate minimum of three operations
            curr_row[i+1] = std::cmp::min(
                std::cmp::min(
                    prev_row[i+1] + 1,    // deletion
                    curr_row[i] + 1,      // insertion
                ),
                prev_row[i] + cost        // substitution
            );
        }

        // Swap rows
        std::mem::swap(&mut prev_row, &mut curr_row);
    }

    prev_row[m]
}

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();

    if args.len() < 2 {
        println!("Please provide at least two strings as arguments.");
        return;
    }

    let mut min_distance = None;
    let mut times = 0;

    // Compare all pairs of strings
    for (i, arg1) in args.iter().enumerate() {
        for (j, arg2) in args.iter().enumerate() {
            if i != j {
                let distance = levenshtein_distance(&arg1, &arg2);
                if let Some(current_min) = min_distance {
                    if distance < current_min {
                        min_distance = Some(distance);
                    }
                } else {
                    min_distance = Some(distance);
                }
                times += 1;
            }
        }
    }

    println!("times: {}", times);
    println!("min_distance: {}", min_distance.unwrap_or(usize::MAX));
}
