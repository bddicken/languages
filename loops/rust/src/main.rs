use rayon::prelude::*;
fn main() {
    let u = match std::env::args().nth(1) {
        Some(n) => n.parse::<usize>().unwrap_or(1),
        None => 1,
    };

    let mut a = [0; 10_000];
    let r = rand::random::<usize>() % 10_000;

    a.par_chunks_mut(rayon::current_num_threads())
        .for_each(|slice| {
            for i in slice {
                let acc = (0..100_000).fold(0, |acc, j| acc + j % u);
                *i = acc + r;
            }
        });

    println!("{}", a[r]);
}
