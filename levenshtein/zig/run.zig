const std = @import("std");
const Allocator = std.mem.Allocator;

const benchmark = @import("benchmark");
const levenshteinDistance = @import("./levenshtein.zig").levenshteinDistance;

pub fn calculateDistances(comptime T: type) (fn (allocator: Allocator, word_list: *const std.ArrayList([]const u8)) Allocator.Error!std.ArrayList(T)) {
    return struct {
        fn calc(allocator: Allocator, word_list: *const std.ArrayList([]const u8)) Allocator.Error!std.ArrayList(T) {
            const fn_levenshtein = levenshteinDistance(T);

            var results = try std.ArrayList(T).initCapacity(allocator, (word_list.items.len * (word_list.items.len - 1)) / 2);

            const second_last_index = word_list.items.len - 1;

            for (word_list.items[0..second_last_index], 0..second_last_index) |wordA, i| {
                // rest of words in list for comparison
                const cmp_words = word_list.items[(i + 1)..];

                for (cmp_words, 0..cmp_words.len) |wordB, _| {
                    const distance = fn_levenshtein(allocator, &wordA, &wordB);
                    try results.append(distance);
                }
            }

            return results;
        }
    }.calc;
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    // retrieve arguments for benchmark, contains program arguments
    const args = try benchmark.loadArguments(allocator);

    // parse program arguments
    const word_list = try benchmark.fileReadLines(allocator, args.program_args[0]);

    // try different integer sizes (u32/u64/u128/usize) to see their impact on performance
    const distance_type = u32;

    // perform full benchmark
    const context = benchmark.createContext(calculateDistances(distance_type));
    const stats = (try context.benchmark(allocator, args.warmup_ms, args.run_ms, .{ allocator, &word_list })).?;

    // get last result for success checks
    const last_result = stats.lastResult();

    // sum the distances outside the benchmarked function
    var sum: distance_type = 0;

    for ((try last_result).items) |distance| {
        sum += distance;
    }

    // output results
    try stats.printOutput(allocator, sum);
}
