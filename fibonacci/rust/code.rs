fn main() {
    let u: i32 = std::env::args()
        .nth(1)
        .unwrap()
        .parse()
        .unwrap();
    let mut r = 0;
    for i in 1..u {
        r += fibonacci(i);
    }
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
