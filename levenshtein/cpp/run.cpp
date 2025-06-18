#include <algorithm>
#include <chrono>
#include <filesystem>
#include <fstream>
#include <print>
#include <span>
#include <string_view>
#include <vector>

#include "benchmark.hpp"

namespace {

//
// Calculates the Levenshtein distance between two strings using an optimized
// version of Wagner-Fischer algorithm that uses O(min(m,n)) space.
//
// @param first The first string to compare
// @param second The second string to compare
// @return The Levenshtein distance between first and second
//
[[nodiscard]] auto levenshtein(std::string_view first, std::string_view second)
    -> int {
    // Optimize by ensuring str1 is the shorter string to minimize space usage
    if (second.length() < first.length()) std::swap(first, second);

    const int m = static_cast<int>(first.length());
    const int n = static_cast<int>(second.length());

    // Only need two rows for the dynamic programming matrix
    std::vector<int> previous_row(m + 1);
    std::vector<int> current_row(m + 1);

    // Initialize first row with incremental values
    for (int distance = 0; auto& column : previous_row) column = distance++;

    // Fill the matrix row by row
    for (int i = 1; i <= n; ++i) {
        current_row[0] = i;  // Initialize first column
        for (int j = 1; j <= m; ++j) {
            // Calculate cost - 0 if characters are same, 1 if different
            const int cost = static_cast<int>(first[j - 1] != second[i - 1]);

            // Calculate minimum of deletion, insertion, and substitution
            current_row[j] = std::min({
                previous_row[j] + 1,        // deletion
                current_row[j - 1] + 1,     // insertion
                previous_row[j - 1] + cost  // substitution
            });
        }
        // Swap rows using vector's efficient swap
        previous_row.swap(current_row);
    }

    return previous_row.back();  // Final distance is in the last cell
}

//
// Distances helper class disambiguates type for std::print
//
struct Distances {
    std::vector<int> values;
};

[[nodiscard]] auto calculateDistances(const std::vector<std::string>& words)
    -> Distances {
    auto results = Distances{};
    results.values.reserve(words.size() * (words.size() - 1) / 2);

    // Optimize loop to avoid redundant comparisons (i,j) vs (j,i)
    // since Levenshtein distance is symmetric
    for (auto first = words.begin(); first != std::prev(words.end()); ++first) {
        for (auto second = std::next(first); second != words.end(); ++second) {
            results.values.emplace_back(levenshtein(*first, *second));
        }
    }

    return results;
}

[[nodiscard]] auto readWords(const std::filesystem::path& filename)
    -> std::vector<std::string> {
    auto words = std::vector<std::string>{};
    auto line  = std::string{};
    auto file  = std::ifstream{filename};
    while (std::getline(file, line)) words.push_back(line);
    return words;
}

}  // namespace

//
// Custom formatter for Distances that prints out the sum of all values.
//
template <>
struct std::formatter<Distances> {
    [[nodiscard]] constexpr auto parse(std::format_parse_context& ctx) {
        return ctx.begin();
    }

    [[nodiscard]] constexpr auto format(const Distances& distances,
                                        std::format_context& ctx) const {
        const auto sum =
            std::ranges::fold_left(distances.values, 0, std::plus{});
        return std::format_to(ctx.out(), "{}", sum);
    }
};

auto main(int argc, char* argv[]) -> int {
    const auto args = std::span{argv, static_cast<size_t>(argc)};

    if (args.size() != 4) {
        std::println("Usage: {} <duration_in_ms> <warmup_in_ms> <input_file>",
                     args.front());
        return 1;
    }

    const auto words = readWords(args[3]);

    // Warmup
    const auto warmup_for = std::chrono::milliseconds{std::atoi(args[2])};
    benchmark::run(warmup_for, calculateDistances, words);

    // Benchmark
    const auto run_for = std::chrono::milliseconds{std::atoi(args[1])};
    std::println("{}", benchmark::run(run_for, calculateDistances, words));
}
