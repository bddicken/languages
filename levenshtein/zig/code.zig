const std = @import("std");

/// Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
/// Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
/// Time Complexity: O(m*n) where m and n are the lengths of the input strings
fn levenshteinDistance(s1: []const u8, s2: []const u8) usize {
    // Early termination checks
    if (std.mem.eql(u8, s1, s2)) return 0;
    if (s1.len == 0) return s2.len;
    if (s2.len == 0) return s1.len;

    // Make s1 the shorter string for space optimization
    const str1 = if (s1.len > s2.len) s2 else s1;
    const str2 = if (s1.len > s2.len) s1 else s2;

    const m = str1.len;
    const n = str2.len;

    // Use two arrays instead of full matrix for space optimization
    var prev_row: [256]usize = undefined;
    var curr_row: [256]usize = undefined;

    // Initialize first row
    for (0..m + 1) |i| {
        prev_row[i] = i;
    }

    // Main computation loop
    var j: usize = 1;
    while (j <= n) : (j += 1) {
        curr_row[0] = j;

        var i: usize = 1;
        while (i <= m) : (i += 1) {
            const cost: usize = if (str1[i - 1] == str2[j - 1]) 0 else 1;
            
            // Calculate minimum of three operations
            curr_row[i] = @min(
                @min(
                    prev_row[i] + 1,      // deletion
                    curr_row[i - 1] + 1,  // insertion
                ),
                prev_row[i - 1] + cost    // substitution
            );
        }

        // Swap rows
        @memcpy(prev_row[0..m + 1], curr_row[0..m + 1]);
    }

    return prev_row[m];
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 3) {
        const stderr = std.io.getStdErr().writer();
        try stderr.writeAll("Please provide at least two strings as arguments.\n");
        std.process.exit(1);
    }

    var min_distance: isize = -1;
    var times: usize = 0;

    // Compare all pairs of strings
    var i: usize = 1;
    while (i < args.len) : (i += 1) {
        var j: usize = 1;
        while (j < args.len) : (j += 1) {
            if (i != j) {
                const distance = levenshteinDistance(args[i], args[j]);
                if (min_distance == -1 or distance < @as(usize, @intCast(min_distance))) {
                    min_distance = @as(isize, @intCast(distance));
                }
                times += 1;
            }
        }
    }

    const stdout = std.io.getStdOut().writer();
    try stdout.print("times: {d}\n", .{times});
    try stdout.print("min_distance: {d}\n", .{min_distance});
}
