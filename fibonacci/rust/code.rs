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
    match n {
        0 => 0,
        1 => 1,
        _ => fibonacci(n - 1) + fibonacci(n - 2),
    }
}