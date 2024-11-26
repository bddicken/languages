fn fibonacci(n: u32) -> u32 {
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}

fn main() {
    let u: u32 = std::env::args()
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