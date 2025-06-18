//
// "Modern", more idiomatic C++ version of the naive Fibonacci
// sequence generator
//
// Changes from the C-based version:
// - Added command line argument count check
// - C++ does not require "return 0" in the main function
// - Trailing return types
// - Convert argv/argc to std::span to void pointer arithmetic
//   and allow for simpler iteration (if needed)
// - C++23 provides std::print() and std::println() to replace
//   std::cout and friends
// - C++23 ranges and algorithms to clarify intent and to avoid
//   raw for loops.
//   See Sean Parents "No raw for loops" and other sources.
//
// Minor performance tweak:
// - Replaced separate if() checks for n == 0 and n == 1 with
//   single n < 2 check.
//

#include <algorithm>
#include <print>
#include <ranges>
#include <span>

[[nodiscard]] auto fibonacci(int n) -> int {
  if (n == 0)
    return 0;
  if (n == 1)
    return 1;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

auto main(int argc, char *argv[]) -> int {
  const auto args = std::span{argv, static_cast<size_t>(argc)};

  if (args.size() != 2) {
    std::println("Usage: {} <iterations>", args.front());
    return 1;
  }

  const auto sum = std::ranges::fold_left(std::views::iota(1, atoi(args[1])) |
                                              std::views::transform(fibonacci),
                                          int{}, std::plus{});

  std::println("{}", sum);
}
