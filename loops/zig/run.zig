const std = @import("std");

const benchmark = @import("benchmark");
const loops = @import("./loops.zig").loops;

const ITERATIONS: u32 = 10_000;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    // retrieve arguments for benchmark, contains program arguments
    const args = try benchmark.loadArguments(allocator);

    // parse program arguments
    // try different integer sizes for numbers N (u32/u64/u128/usize)
    const divisor = try std.fmt.parseInt(u32, args.program_args[0], 0);

    // perform full benchmark
    // try different integer sizes for RNG (u16/u32/u64/u128/usize)
    const context = benchmark.createContext(loops(u32, @TypeOf(divisor), ITERATIONS, ITERATIONS));
    const stats = (try context.benchmark(allocator, args.warmup_ms, args.run_ms, .{divisor})).?;

    // get last result for success checks
    const last_result = stats.lastResult();

    // output results
    try stats.printOutput(allocator, last_result);
}
