const std = @import("std");
const rand = std.crypto.random;
const stdout = std.io.getStdOut().writer();

pub fn main() !void {
    // Get an input number from the command line
    var args = std.process.args();
    if (!args.skip()) {
        unreachable; // Trigger an error or panic when skip() returns false
    }
    const allocator = std.heap.page_allocator;
    const arg = args.next(allocator) orelse unreachable;
    const u = try std.fmt.parseInt(usize, arg, 10);

    // Get a random number 0 <= r < 10k
    const r = rand.intRangeAtMost(usize, 0, 10000);

    // Array of 10k elements initialized to 0
    var a: [10000]usize = undefined;
    @memset(&a, 0, sizeof(a));

    // 10k outer loop iterations
    for (std.range(0, 10000)) |i| {
        // 100k inner loop iterations, per outer loop iteration
        for (std.range(0, 100000)) |j| {
            a[i] += j % u; // Simple sum
        }
        a[i] += r; // Add a random value to each element in array
    }

    try stdout.print("{d}\n", .{a[r]}); // Print out a single element from the array
}
