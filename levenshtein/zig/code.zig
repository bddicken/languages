const std = @import("std");

/// Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
/// Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
/// Time Complexity: O(m*n) where m and n are the lengths of the input strings
fn levenshteinDistance(s1: []const u8, s2: []const u8) usize {
    // Early termination checks
    if (s1.len == 0) return s2.len;
    if (s2.len == 0) return s1.len;

    // Make s1 the shorter string for space optimization
    const str1 = if (s1.len > s2.len) s2 else s1;
    const str2 = if (s1.len > s2.len) s1 else s2;

    const m = str1.len;
    const n = str2.len;

    // Initialize arrays
    var prev_row: [1024]usize = undefined;
    var curr_row: [1024]usize = undefined;

    // Initialize first row
    for (0..m + 1) |i| {
        prev_row[i] = i;
    }

    // Main computation loop

    for (1..(n + 1)) |j| {
        curr_row[0] = j;

        for (1..(m + 1)) |i| {
            const cost: usize = if (str1[i - 1] == str2[j - 1]) 0 else 1;

            // Calculate minimum of three operations
            curr_row[i] = @min(prev_row[i] + 1, // deletion
                curr_row[i - 1] + 1, // insertion
                prev_row[i - 1] + cost // substitution
            );
        }

        // Swap rows
        @memcpy(prev_row[0 .. m + 1], curr_row[0 .. m + 1]);
    }

    return prev_row[m];
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const args = try std.process.argsAlloc(allocator);

    if (args.len < 3) {
        const stderr = std.io.getStdErr().writer();
        try stderr.writeAll("Please provide at least two strings as arguments.\n");
        std.process.exit(1);
    }

    var min_distance: usize = std.math.maxInt(usize);
    var times: usize = 0;

    // Compare all pairs of strings

    for (1..args.len) |i| {
        for (1..args.len) |j| {
            if (i != j) {
                const distance = levenshteinDistance(args[i], args[j]);
                if (distance < min_distance) {
                    min_distance = distance;
                }
                times += 1;
            }
        }
    }

    const stdout = std.io.getStdOut().writer();
    try stdout.print("times: {d}\n", .{times});
    try stdout.print("min_distance: {d}\n", .{min_distance});
}
