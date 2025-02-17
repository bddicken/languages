const std = @import("std");
const Allocator = std.mem.Allocator;

/// Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm.
///
/// Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
/// Time Complexity: O(m*n) - where m and n are the lengths of the input strings
pub fn levenshteinDistance(comptime T: type) (fn (allocator: Allocator, s1: *const []const u8, s2: *const []const u8) T) {
    return struct {
        pub fn levenshtein(allocator: Allocator, s1: *const []const u8, s2: *const []const u8) T {
            // early termination checks
            if (s1.*.len == 0) return @intCast(s2.*.len);
            if (s2.*.len == 0) return @intCast(s1.*.len);

            // make s1 the shorter string for space optimization
            const str1, const str2 = init: {
                if (s1.*.len > s2.*.len) {
                    break :init .{ s2.*, s1.* };
                }

                break :init .{ s1.*, s2.* };
            };

            const m = str1.len;
            const n = str2.len;

            const row_elements = m + 1;

            // use two rows instead of full matrix for space optimization
            var prev_row: []T = allocator.alloc(T, row_elements) catch unreachable;
            var curr_row: []T = allocator.alloc(T, row_elements) catch unreachable;
            defer allocator.free(prev_row);
            defer allocator.free(curr_row);

            // initialize first row
            for (0..m + 1) |i| {
                prev_row[i] = @intCast(i);
            }

            // main computation loop
            for (str2, 0..n) |ch2, j| {
                curr_row[0] = @as(T, @intCast(j)) + 1;

                for (str1, 0..m) |ch1, i| {
                    const cost: T = @intFromBool(ch1 != ch2);

                    // calculate minimum of three operations
                    curr_row[i + 1] = @min(
                        prev_row[i + 1] + 1, // deletion
                        curr_row[i] + 1, // insertion
                        prev_row[i] + cost, // substitution
                    );
                }

                // swap rows
                std.mem.swap([]T, &prev_row, &curr_row);
            }

            return prev_row[m];
        }
    }.levenshtein;
}
