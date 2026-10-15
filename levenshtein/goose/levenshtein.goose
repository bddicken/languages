// The Levenshtein distance by Wagner-Fischer, in O(min(m, n)) space: two rows
// as long as the shorter string plus one, made for each call and swapped
// after each row rather than copied.

import std;

fn levenshtein_distance(s1: u8[:], s2: u8[:]) -> u32 {
    // The shorter string is the column dimension.
    let shorter = if s1.len <= s2.len { s1 } else { s2 };
    let longer = if s1.len <= s2.len { s2 } else { s1 };
    let m = shorter.len;

    // The rows grow on data stacks of their own: making one is a pointer
    // bump, and the call's return takes both back.
    var prev_row: u32[>..] = [];
    var curr_row: u32[>..] = [];
    for i in m + 1 { prev_row.push(i as u32); }
    push_n(curr_row, 0, m + 1);
    var prev: u32[:] = prev_row;
    var curr: u32[:] = curr_row;

    for ch2, j in longer {
        assert(prev.len == m + 1 && curr.len == m + 1);
        curr[0] = (j + 1) as u32;
        for i in m {
            let cost: u32 = if shorter[i] != ch2 { 1 } else { 0 };
            curr[i + 1] = min(min(prev[i + 1] + 1, curr[i] + 1), prev[i] + cost);
        }
        swap(prev, curr);
    }
    return prev[m];
}

// The distance of every pair of words, each pair once.
fn distances(words: const u8[:][:]) -> u32[>..] {
    var out: u32[>..] = [];
    for i in words.len {
        for j in i + 1..words.len {
            out.push(levenshtein_distance(words[i], words[j]));
        }
    }
    return out;
}
