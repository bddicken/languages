// fibonacci(n) by naive recursion: an early return for n < 2, two recursive
// calls otherwise.
recursive fn fibonacci(n: i32) -> i32 {
    if n < 2 { return n; }
    return fibonacci(n - 1) + fibonacci(n - 2);
}
