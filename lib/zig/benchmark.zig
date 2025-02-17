const std = @import("std");
const Allocator = std.mem.Allocator;
const Timer = std.time.Timer;

const INITIAL_CAPACITY: usize = 1_000;

pub const ArgumentList = struct {
    run_ms: usize,
    warmup_ms: usize,
    program_args: [][]u8,
};

pub fn FnReturnType(comptime function: anytype) type {
    return @typeInfo(@TypeOf(function)).Fn.return_type.?;
}

pub fn TimedResult(comptime T: type) type {
    return struct {
        elapsed_total: u64,
        elapsed: u64,
        value: T,
    };
}

pub fn BenchmarkResult(comptime T: type) type {
    return struct {
        const Self = @This();

        mean_ms: f64,
        std_dev_ms: f64,
        min_ms: f64,
        max_ms: f64,
        runs: usize,
        results: std.ArrayList(TimedResult(T)),

        pub fn lastResult(self: *const Self) T {
            return self.results.getLast().value;
        }

        pub fn formatOutput(self: *const Self, allocator: Allocator, check_value: anytype) ![]u8 {
            return std.fmt.allocPrint(
                allocator,
                "{d:.6},{d:.6},{d:.6},{d:.6},{d},{any}",
                .{
                    self.mean_ms,
                    self.std_dev_ms,
                    self.min_ms,
                    self.max_ms,
                    self.runs,
                    check_value,
                },
            );
        }

        pub fn printOutput(self: *const Self, allocator: Allocator, check_value: anytype) !void {
            const formatted_output = try self.formatOutput(allocator, check_value);

            const stdout = std.io.getStdOut().writer();
            try stdout.print("{s}\n", .{formatted_output});
        }
    };
}

pub fn createContext(comptime benchmark_fn: anytype) type {
    // store the return type for the working function
    const return_type = FnReturnType(benchmark_fn);

    return struct {
        const Self = @This();

        /// run_ms:
        ///   0: don't run
        ///   1: check-output run
        /// args:
        ///   e.g.: .{ allocator, &arg1, arg2 }
        pub fn run(allocator: Allocator, run_ms: usize, args: anytype) !?BenchmarkResult(return_type) {
            const stderr = std.io.getStdErr().writer();

            var benchmark_results = try std.ArrayList(TimedResult(return_type)).initCapacity(allocator, INITIAL_CAPACITY);

            if (run_ms == 0) {
                return null;
            } else if (run_ms > 1) {
                // start with a status dot, but not if this is a check-output run
                try stderr.writeAll(".");
            }

            const run_ns: usize = run_ms * 1_000_000;

            var elapsed_total: u64 = 0;

            var timer = try Timer.start();
            var last_time = timer.read();

            while (elapsed_total < run_ns) {
                const time_start = timer.read();

                const current_value = @call(.auto, benchmark_fn, args);

                const time_end = timer.read();

                // print status dots every second if it isn't a check-output run
                if (run_ms > 1 and (time_start - last_time) > 1_000_000_000) {
                    last_time = time_end;
                    try stderr.writeAll(".");
                }

                const elapsed = time_end - time_start;
                elapsed_total += elapsed;

                try benchmark_results.append(TimedResult(return_type){
                    .elapsed_total = elapsed_total,
                    .elapsed = elapsed,
                    .value = current_value,
                });
            }

            // add newline for non check-output runs
            if (run_ms > 1) {
                try stderr.writeAll("\n");
            }

            // calculate timings after completing the run
            // (no unnecessary work during benchmark loop)
            const min_ms = Self.calculateMin(&benchmark_results);
            const max_ms = Self.calculateMax(&benchmark_results);
            const mean_ms: f64 = Self.calculateMean(&benchmark_results);
            const std_deviation: f64 = Self.calculateStdDeviation(&benchmark_results, mean_ms);

            return BenchmarkResult(return_type){
                .mean_ms = mean_ms,
                .std_dev_ms = std_deviation,
                .min_ms = min_ms,
                .max_ms = max_ms,
                .runs = benchmark_results.items.len,
                .results = benchmark_results,
            };
        }

        pub fn benchmark(allocator: Allocator, warmup_ms: usize, run_ms: usize, args: anytype) !?BenchmarkResult(return_type) {
            // perform warmup runs
            _ = try Self.run(allocator, warmup_ms, args);

            // perform benchmark runs
            return Self.run(allocator, run_ms, args);
        }

        fn calculateMin(results: *const std.ArrayList(TimedResult(return_type))) f64 {
            var min_ms = std.math.floatMax(f64);

            for (results.items) |result| {
                const milliseconds: f64 = @as(f64, @floatFromInt(result.elapsed)) / 1_000_000.0;

                min_ms = @min(min_ms, milliseconds);
            }

            return min_ms;
        }

        fn calculateMax(results: *const std.ArrayList(TimedResult(return_type))) f64 {
            var max_ms = std.math.floatMin(f64);

            for (results.items) |result| {
                const milliseconds: f64 = @as(f64, @floatFromInt(result.elapsed)) / 1_000_000.0;

                max_ms = @max(max_ms, milliseconds);
            }

            return max_ms;
        }

        fn calculateMean(results: *const std.ArrayList(TimedResult(return_type))) f64 {
            var sum: f64 = 0.0;

            for (results.*.items) |*result| {
                sum += @as(f64, @floatFromInt(result.*.elapsed)) / 1_000_000.0;
            }

            return sum / @as(f64, @floatFromInt(results.*.items.len));
        }

        fn calculateStdDeviation(results: *const std.ArrayList(TimedResult(return_type)), mean_ms: f64) f64 {
            var sum_squares: f64 = 0.0;

            for (results.*.items) |*result| {
                const diff: f64 = (@as(f64, @floatFromInt(result.*.elapsed)) / 1_000_000.0) - mean_ms;
                sum_squares += diff * diff;
            }

            return std.math.sqrt(sum_squares / @as(f64, @floatFromInt(results.*.items.len)));
        }
    };
}

// Helper Functions

pub fn loadArguments(allocator: Allocator) !ArgumentList {
    const args_cli = try std.process.argsAlloc(allocator);

    if (args_cli.len < 4) {
        const stderr = std.io.getStdErr().writer();
        try stderr.print("Usage: {s} <run_ms> <warmup_ms> ...<program args>\n", .{args_cli[0]});
        std.process.exit(1);
    }

    const args = args_cli[1..];

    const run_ms: usize = try std.fmt.parseInt(usize, args[0], 0);
    const warmup_ms: usize = try std.fmt.parseInt(usize, args[1], 0);

    return ArgumentList{
        .run_ms = run_ms,
        .warmup_ms = warmup_ms,
        .program_args = args[2..],
    };
}

pub fn fileReadLines(allocator: Allocator, file_path: []const u8) !std.ArrayList([]const u8) {
    var file = try std.fs.cwd().openFile(file_path, .{ .mode = std.fs.File.OpenMode.read_only });
    defer file.close();

    const stat = try file.stat();
    const file_buffer = try file.readToEndAlloc(allocator, stat.size);

    var word_list = std.ArrayList([]const u8).init(allocator);

    // Split by "\r?\n" and iterate through the resulting slices of "[]const u8"
    var lines = std.mem.tokenizeAny(u8, file_buffer, "\r\n");

    while (lines.next()) |line| {
        try word_list.append(line);
    }

    return word_list;
}
