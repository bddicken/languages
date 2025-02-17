#include <array>
#include <chrono>
#include <print>
#include <random>
#include <span>

#include "benchmark.hpp"

namespace {

constexpr auto LOOPS = 10'000;

[[nodiscard]] auto randomValue() -> int {
    static auto random_device = std::random_device{};
    static auto random_engine = std::mt19937{random_device()};
    static auto distribution = std::uniform_int_distribution<int>{0, LOOPS - 1};
    return distribution(random_engine);
}

[[nodiscard]] auto loops(int number) -> int {
    auto numbers      = std::array<int, LOOPS>{};
    auto random_value = randomValue();

    for (int i = 0; i != LOOPS; ++i) {
        for (int j = 0; j != LOOPS; ++j) {
            numbers[i] += j % number;
        }
        numbers[i] += random_value;
    }

    return numbers[random_value];
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
    benchmark::run(warmup_for, loops, number);

    // Benchmark
    const auto run_for = std::chrono::milliseconds{std::atoi(args[1])};
    std::println("{}", benchmark::run(run_for, loops, number));
}
