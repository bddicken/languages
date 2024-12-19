fn fibonacci(n: u32) -> u32 {
    let mut a = 0;
    let mut b = 1;
    for _ in 0..n {
        let temp = a;
        a = b;
        b = temp + b;
    }
    a
}

fn main() {
    let input = std::env::args()
        .nth(1)
        .expect("Please provide a number as an argument");
    let u: u32 = input.parse().expect("Failed to parse input as a number");

    let sum: u32 = (0..u).map(fibonacci).sum();

    println!("{}", sum);
}
