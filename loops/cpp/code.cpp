#include <string>
#include <random>
#include <array>
#include <print>
#include <cstdint>
#include <ranges>

int main (int argc, char* argv[])
{
    int const mod = std::stoi(argv[1]);                         // Get an input number from the command line
    std::random_device rd{};
    std::mt19937 engine{rd()};
    std::uniform_int_distribution<int> dist{0, 9999};           // <random> library setup

    int const picked_number = dist(engine);                     // Get a random number 0 <= r < 10k
    std::array<std::int32_t, 10000> array{};                    // Array of 10k elements initialized to 0
    for (int const i : std::ranges::views::iota(0, 10000))      // 10k outer loop iterations
    {
        for (int const j : std::ranges::views::iota(0, 100000)) // 100k inner loop iterations, per outer loop iteration
            array[i] += j % mod;                                // Simple sum
        array[i] += picked_number;                              // Add a random value to each element in array
    }
    std::println("{}", array[picked_number]);                   // Print out a single element from the array
}
