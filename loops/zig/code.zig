const std = @import("std");
const rand = std.crypto.random;

const loops = @import("./loops.zig").loops;

const LOOPS_OUTER: u32 = 10_000;
const LOOPS_INNER: u32 = 100_000;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const args_cli = try std.process.argsAlloc(allocator);

    if (args_cli.len < 2) {
        const stderr = std.io.getStdErr().writer();
        try stderr.writeAll("Please provide a number as argument.\n");
        std.process.exit(1);
    }

    const args = args_cli[1..];

    // try different integer sizes for numbers N (u32/u64/u128/usize)
    const divisor = try std.fmt.parseInt(u32, args[0], 0);

    // try different integer sizes for RNG (u16/u32/u64/u128/usize)
    const fn_loops = loops(u32, @TypeOf(divisor), LOOPS_OUTER, LOOPS_INNER);

    const result = fn_loops(divisor);

    const stdout = std.io.getStdOut().writer();
    try stdout.print("{d}\n", .{result}); // Print out a single element from the array
}
