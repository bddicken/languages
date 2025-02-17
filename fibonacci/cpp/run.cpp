#include <chrono>
#include <print>
#include <span>

#include "benchmark.hpp"

namespace {

[[nodiscard]] auto fibonnaci(int n) -> int {
    if (n < 2) return n;
    return fibonnaci(n - 1) + fibonnaci(n - 2);
}

}  // namespace

auto main(int argc, char* argv[]) -> int {
    const auto args = std::span{argv, static_cast<size_t>(argc)};

    if (args.size() != 4) {
        std::println(
            "Usage: {} <duration_in_ms> <warmup_in_ms> <function_argument>",
            args.front());
        return 1;
    }

    const auto number = std::atoi(args[3]);

    // Warmup
    const auto warmup_for = std::chrono::milliseconds{std::atoi(args[2])};
    benchmark::run(warmup_for, fibonnaci, number);

    // Benchmark
    const auto run_for = std::chrono::milliseconds{std::atoi(args[1])};
    std::println("{}", benchmark::run(run_for, fibonnaci, number));
}
