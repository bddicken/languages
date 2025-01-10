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
    let n = s2_bytes.len();

    // Use two rows instead of full matrix for space optimization
    let mut prev_row = Vec::with_capacity(m + 1);
    for j in 0..=prev_row.capacity() {prev_row.push(j as i32);}
    let mut curr_row:Vec<i32> = vec![0;m+1];
    // Initialize first row

    // Main computation loop
    for j in 1..=n {
        curr_row[0] = j as i32;

        for i in 1..=m {
            let cost = if s1_bytes[i - 1] == s2_bytes[j - 1] { 0 } else { 1 };
            
            // Calculate minimum of three operations
            curr_row[i] = std::cmp::min(
                std::cmp::min(
                    prev_row[i] + 1,      // deletion
                    curr_row[i - 1] + 1,  // insertion
                ),
                prev_row[i - 1] + cost    // substitution
            );
            }

        // Swap rows
        std::mem::swap(&mut prev_row, &mut curr_row);
    }

    prev_row[m].try_into().unwrap()
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
    for i in 0..args.len() {
        for j in 0..args.len() {
            if i != j {
                let distance = levenshtein_distance(&args[i], &args[j]);
                min_distance = std::cmp::min(distance, min_distance);
                times += 1;
            }
        }
    }

    println!("times: {}", times);
    println!("min_distance: {}", min_distance);
}
