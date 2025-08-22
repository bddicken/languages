const std = @import("std");

const rand = std.crypto.random;

pub fn loops(comptime R: type, comptime N: type, comptime iterations_outer: usize, comptime iterations_inner: usize) fn (N) N {
    return struct {
        fn loop(divisor: N) N {
            // get a random number 0 <= r < 10k
            const random = rand.intRangeLessThanBiased(R, 0, 10_000);

            // array of 10k elements initialized to 0
            var arr = [_]N{0} ** iterations_outer;

            // outer loop iterations
            // iterate over array itself to prevent permanent bound checks for arr[i]
            for (&arr) |*elem| {
                // inner loop iterations, per outer loop iteration
                for (0..iterations_inner) |j| {
                    // simple sum
                    elem.* += @as(N, @intCast(j)) % divisor;
                }

                // add a random value to each element in array
                elem.* += @intCast(random);
            }

            return arr[@intCast(random)];
        }
    }.loop;
}
