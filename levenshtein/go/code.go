package main

import (
	"fmt"
	"os"
)

// levenshtein calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
// Space Complexity: O(min(m,n)) - only uses two rows instead of full matrix
// Time Complexity: O(m*n) where m and n are the lengths of the input strings
func levenshtein(s1, s2 string) int {
	// Early termination checks
	if s1 == s2 {
		return 0
	}
	if len(s1) == 0 {
		return len(s2)
	}
	if len(s2) == 0 {
		return len(s1)
	}

	// Make s1 the shorter string for space optimization
	if len(s1) > len(s2) {
		s1, s2 = s2, s1
	}

	m, n := len(s1), len(s2)

	// Use two rows instead of full matrix for space optimization
	prevRow := make([]int, m+1)
	currRow := make([]int, m+1)

	// Initialize first row
	for i := 0; i <= m; i++ {
		prevRow[i] = i
	}

	// Main computation loop
	for j := 1; j <= n; j++ {
		currRow[0] = j

		for i := 1; i <= m; i++ {
			cost := 1
			if s1[i-1] == s2[j-1] {
				cost = 0
			}
			
			// Find minimum of three operations
			deletion := prevRow[i] + 1
			insertion := currRow[i-1] + 1
			substitution := prevRow[i-1] + cost
			
			currRow[i] = deletion
			if insertion < currRow[i] {
				currRow[i] = insertion
			}
			if substitution < currRow[i] {
				currRow[i] = substitution
			}
		}

		// Swap rows
		prevRow, currRow = currRow, prevRow
	}

	return prevRow[m]
}

func main() {
	args := os.Args[1:]

	minD := -1
	times := 0

	if len(args) < 2 {
		fmt.Println("Please provide at least two strings as arguments.")
		return
	}

	for i := 0; i < len(args); i++ {
		for j := 0; j < len(args); j++ {
			if  i != j {
        d := levenshtein(args[i], args[j])
        if minD == -1 || d < minD {
          minD = d
        }
        times++
      }
		}
	}

	fmt.Printf("times: %d\n", times)
	fmt.Printf("min_distance: %d\n", minD)
}
