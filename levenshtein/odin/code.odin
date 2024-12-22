package main

import "core:fmt"
import "core:os"
import "core:strings"
import "base:runtime"

// Calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
// Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
// Time Complexity: O(m*n) where m and n are the lengths of the input strings
levenshtein_distance :: proc(s1, s2: string) -> int #no_bounds_check {
    // Early termination checks
    if s1 == s2 do return 0
    if len(s1) == 0 do return len(s2)
    if len(s2) == 0 do return len(s1)

    // Make s1 the shorter string for space optimization
    s1, s2 := s1, s2
    if len(s1) > len(s2) {
        s1, s2 = s2, s1
    }

    m := len(s1)
    n := len(s2)

    // Use two arrays instead of full matrix for space optimization
    prev_row := make([]int, m + 1, context.temp_allocator)
    curr_row := make([]int, m + 1, context.temp_allocator)

    // Initialize first row
    for i := 0; i <= m; i += 1 {
        prev_row[i] = i
    }

    // Main computation loop
    for j := 1; j <= n; j += 1 {
        curr_row[0] = j

        for i := 1; i <= m; i += 1 {
            cost := 1
            if s1[i-1] == s2[j-1] {
                cost = 0
            }

            // Calculate minimum of three operations
            deletion := prev_row[i] + 1
            insertion := curr_row[i-1] + 1
            substitution := prev_row[i-1] + cost

            curr_row[i] = min(deletion, min(insertion, substitution))
        }

        // Swap rows
        prev_row, curr_row = curr_row, prev_row
    }

    return prev_row[m]
}

main :: proc() {
    args := os.args[1:]

    if len(args) < 2 {
        fmt.println("Please provide at least two strings as arguments.")
        os.exit(1)
    }

    min_distance := -1
    times := 0

    // Compare all pairs of strings
    for i := 0; i < len(args); i += 1 {
        for j := 0; j < len(args); j += 1 {
            if i != j {
                distance := levenshtein_distance(args[i], args[j])
                if min_distance == -1 || distance < min_distance {
                    min_distance = distance
                }
                times += 1
            }
        }
    }

    fmt.printf("times: %d\n", times)
    fmt.printf("min_distance: %d\n", min_distance)
}
