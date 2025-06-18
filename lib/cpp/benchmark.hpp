#ifndef CPP_BENCHMARK_HPP
#define CPP_BENCHMARK_HPP

#include <algorithm>
#include <chrono>
#include <cmath>
#include <functional>
#include <iostream>
#include <limits>
#include <print>
#include <ranges>
#include <ratio>
#include <vector>

namespace benchmark {

using Runtimes = std::vector<std::chrono::nanoseconds>;

template <typename RESULT_TYPE>
struct Statistics {
    std::chrono::nanoseconds mean_runtime{};
    std::chrono::nanoseconds standard_deviation{};
    std::chrono::nanoseconds minimum_runtime{std::numeric_limits<long>::max()};
    std::chrono::nanoseconds maximum_runtime{std::numeric_limits<long>::min()};
    size_t number_of_runs{};
    RESULT_TYPE last_result{};
};

template <typename CLOCK>
class ProgressReport {
    using time_point = typename CLOCK::time_point;

    bool enabled_;
    time_point last_status_;

   public:
    [[nodiscard]] constexpr explicit ProgressReport(bool enable)
        : enabled_{enable} {}

    ~ProgressReport() {
        if (enabled_) std::cerr << std::endl;  // NOLINT - Flush is intentional
    }

    void update() {
        if (enabled_ and
            CLOCK::now() - last_status_ > std::chrono::seconds{1}) {
            last_status_ = CLOCK::now();
            std::cerr << '.' << std::flush;
        }
    }
};

[[nodiscard]] constexpr auto standard_deviation(
    const Runtimes& values, const std::chrono::nanoseconds& mean)
    -> std::chrono::nanoseconds {
    const auto square_difference = [&](const auto& value) {
        const auto difference = (value - mean).count();
        return std::chrono::nanoseconds{difference * difference};
    };
    const auto sum_squares = std::ranges::fold_left(
        values | std::views::transform(square_difference),
        std::chrono::nanoseconds{}, std::plus{});
    return std::chrono::nanoseconds{
        static_cast<long>(std::sqrt(sum_squares.count() / values.size()))};
}

template <typename BENCHMARK_FN, typename... ARGS>
auto run(std::chrono::milliseconds run_for, BENCHMARK_FN&& benchmark_fn,
         ARGS... args) -> Statistics<decltype(benchmark_fn(args...))> {
    using clock = std::chrono::high_resolution_clock;

    auto statistics = Statistics<decltype(benchmark_fn(args...))>{};
    auto run_times  = Runtimes{};

    auto total_elapsed = std::chrono::nanoseconds{};

    auto progress_report =
        ProgressReport<std::chrono::high_resolution_clock>(run_for.count() > 1);
    while (total_elapsed < run_for) {
        const auto start = clock::now();
        statistics.last_result =
            std::invoke(benchmark_fn, std::forward<ARGS>(args)...);
        const auto elapsed = clock::now() - start;
        total_elapsed += elapsed;
        run_times.emplace_back(elapsed);

        ++statistics.number_of_runs;
        statistics.minimum_runtime =
            std::min(statistics.minimum_runtime, elapsed);
        statistics.maximum_runtime =
            std::max(statistics.maximum_runtime, elapsed);

        progress_report.update();
    }

    if (run_times.empty()) return {};

    statistics.mean_runtime = total_elapsed / run_times.size();
    statistics.standard_deviation =
        standard_deviation(run_times, statistics.mean_runtime);
    return statistics;
}

}  // namespace benchmark

template <typename RESULT_TYPE>
struct std::formatter<benchmark::Statistics<RESULT_TYPE>> {
    [[nodiscard]] constexpr auto parse(std::format_parse_context& ctx) {
        return ctx.begin();
    }

    [[nodiscard]] constexpr auto format(
        const benchmark::Statistics<RESULT_TYPE>& statistics,
        std::format_context& ctx) const {
        using as_ms = std::chrono::duration<double, std::milli>;
        using std::chrono::duration_cast;
        return std::format_to(
            ctx.out(), "{:0.6F},{:0.6F},{:0.6F},{:0.6F},{},{}",
            duration_cast<as_ms>(statistics.mean_runtime).count(),
            duration_cast<as_ms>(statistics.standard_deviation).count(),
            duration_cast<as_ms>(statistics.minimum_runtime).count(),
            duration_cast<as_ms>(statistics.maximum_runtime).count(),
            statistics.number_of_runs, statistics.last_result);
    }
};

#endif  // CPP_BENCHMARK_HPP
