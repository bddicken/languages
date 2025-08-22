const std = @import("std");

pub fn main() !void {
    const stdout = std.fs.File.stdout();
    try stdout.writeAll("Hello, World!\n");
}
