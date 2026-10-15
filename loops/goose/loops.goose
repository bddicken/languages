// 100 million updates to an array: for each of 10k elements, 10k additions
// of j % u, then a random value r in [0, 10k), and element r is the result.
//
// The generator is seeded once from entropy, as the C++ version's is. The
// arithmetic is unsigned, as in the Rust version: Goose's `%` is Euclidean,
// which for a signed type also has to adjust a negative remainder.

import std;
import os;

var generator = rng { random_seed() };

fn loops(u: u32) -> u32 {
    let r = generator.rand_int(10000);
    var a: u32[10000] = [0; 10000];
    for i in 10000 {
        for j: u32 in 0..10000 {
            a[i] = a[i] + j % u;
        }
        a[i] += r as u32;
    }
    return a[r];
}
