const std = @import("std");
const stdout = std.io.getStdOut().writer();

fn fib(n: u64) u64 {
    return switch (n) {
        0 => 0,
        1 => 1,
        else => fib(n - 1) + fib(n - 2),
    };
}

pub fn main() !void {
    var args = std.process.args();
    _ = args.next() orelse unreachable; // skip first, which is program name
    const arg = args.next() orelse unreachable;
    const u = try std.fmt.parseInt(usize, arg, 10);

    var r: u64 = 0;
    if (u > 0) {
        for (1..u) |i| {
            r += fib(i);
        }
    }
    try stdout.print("{d}\n", .{r});
}
