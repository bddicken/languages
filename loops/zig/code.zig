const std = @import("std");
const rand = std.crypto.random;
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    // Get an input number from the command line
    var args = std.process.args();
    _ = args.next() orelse unreachable; // skip first, which is program name
    const arg = args.next() orelse unreachable;
    const u = try std.fmt.parseInt(usize, arg, 10);

    // Get a random number 0 <= r < 10k
    const r = rand.intRangeAtMost(usize, 0, 10000);

    // Array of 10k elements initialized to 0
    var a: [10000]usize = undefined;
    @memset(&a, 0);

    // 10k outer loop iterations
    for (0..10000) |i| {
        // 100k inner loop iterations, per outer loop iteration
        for (0..100000) |j| {
            a[i] += j % u; // Simple sum
        }
        a[i] += r; // Add a random value to each element in array
    }

    try stdout.print("{d}\n", .{a[r]}); // Print out a single element from the array
}
