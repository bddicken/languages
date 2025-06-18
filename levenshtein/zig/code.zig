const std = @import("std");

const levenshteinDistance = @import("./levenshtein.zig").levenshteinDistance;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const args_cli = try std.process.argsAlloc(allocator);

    if (args_cli.len < 3) {
        const stderr = std.io.getStdErr().writer();
        try stderr.writeAll("Please provide at least two strings as arguments.\n");
        std.process.exit(1);
    }

    const args = args_cli[1..];

    // try different integer sizes (u32/u64/u128/usize) to see their impact on performance
    const distance_type = u32;

    var min_distance: distance_type = std.math.maxInt(distance_type);
    var times: usize = 0;

    const fn_levenshtein = levenshteinDistance(@TypeOf(min_distance));

    // compare all pairs of strings
    for (args, 0..args.len) |argA, i| {
        for (args, 0..args.len) |argB, j| {
            if (i == j) {
                continue;
            }

            const distance = fn_levenshtein(allocator, &argA, &argB);
            min_distance = @min(min_distance, distance);

            times += 1;
        }
    }

    const stdout = std.io.getStdOut().writer();
    try stdout.print("times: {d}\n", .{times});
    try stdout.print("min_distance: {d}\n", .{min_distance});
}
