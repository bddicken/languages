pub fn fibonacci(comptime T: type) fn (T) T {
    return struct {
        pub fn fib(n: T) T {
            return switch (n) {
                0...1 => n,
                else => fib(n - 1) + fib(n - 2),
            };
        }
    }.fib;
}
