use num::{traits::bounds::UpperBounded, FromPrimitive, Integer, ToPrimitive, Unsigned};

/// Define alias for Trait Bounds until official Trait Aliases are no longer experimental.
///   - see https://github.com/rust-lang/rust/issues/41517
///   - see https://github.com/rust-lang/rfcs/issues/3528#issuecomment-1807738102
///   - see https://github.com/rust-lang/rfcs/pull/1733#issuecomment-243840014
pub trait CostInteger:
    Unsigned + Integer + Copy + UpperBounded + FromPrimitive + ToPrimitive + From<bool>
{
}
impl<T: Unsigned + Integer + Copy + UpperBounded + FromPrimitive + ToPrimitive + From<bool>>
    CostInteger for T
{
}

/// Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm.
///
/// Space Complexity: O(min(m,n)) - only uses two rows instead of full matrix
/// Time Complexity: O(m*n) - where m and n are the lengths of the input strings
pub fn levenshtein_distance<T: CostInteger>(s1: &impl AsRef<str>, s2: &impl AsRef<str>) -> T {
    let s1: &str = s1.as_ref();
    let s2: &str = s2.as_ref();

    // correctness checks
    assert!(s1.len().max(s2.len()) < T::max_value().to_usize().expect("max value") / 2);
    assert!(s1.is_ascii() && s2.is_ascii());

    // make s1 the shorter string for space optimization
    let (s1, s2) = if s1.len() > s2.len() {
        (s2.as_bytes(), s1.as_bytes())
    } else {
        (s1.as_bytes(), s2.as_bytes())
    };

    let m = s1.len();

    let row_elements = m + 1;

    // use two rows instead of full matrix for space optimization
    let mut prev_row: Vec<T> = (0..row_elements)
        .map(|i| T::from_usize(i).expect("init value"))
        .collect();
    let mut curr_row: Vec<T> = vec![T::zero(); row_elements];

    // main computation loop
    for (j, ch2) in s2.iter().enumerate() {
        curr_row[0] = T::from_usize(j + 1).expect("first element");

        for (i, ch1) in s1.iter().enumerate() {
            let cost: T = (ch1 != ch2).into();

            // calculate minimum of three operations
            curr_row[i + 1] = (prev_row[i + 1] + T::one()) // deletion
                .min(curr_row[i] + T::one()) // insertion
                .min(prev_row[i] + cost); // substitution
        }

        // swap rows
        // (prev_row, curr_row) = (curr_row, prev_row);
        std::mem::swap(&mut prev_row, &mut curr_row);
    }

    *prev_row.last().expect("last element")
}
