fn main() {
    let u: i32 = std::env::args()
        .nth(1)
        .unwrap()
        .parse()
        .unwrap();
    let r = (1..u)
        .map(|i| fibonacci(i))
        .fold(0, |acc, x| acc + x);
    println!("{}", r);
}

fn fibonacci(n: i32) -> i32 {
    fibbonaci_accumulator(n, 0, 1)
}
fn fibbonaci_accumulator(n: i32, a: i32, b: i32) -> i32 {
    match n {
        0 => a,
        _ => fibbonaci_accumulator(n - 1, b, a + b),
    }
}
