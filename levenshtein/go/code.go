package main

import (
	"fmt"
	"os"
)

// levenshtein calculates the Levenshtein distance between two strings using Wagner-Fischer algorithm
// Space Complexity: O(min(m,n)) - only uses two rows instead of full matrix
// Time Complexity: O(m*n) where m and n are the lengths of the input strings
func levenshtein(s1, s2 string) int {
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
	var cost int = 1
	for j := 1; j <= n; j++ {
		currRow[0] = j

		for i := 1; i <= m; i++ {
			cost = 1
			if s1[i-1] == s2[j-1] {
				cost = 0
			}

			currRow[i] = prevRow[i] + 1
			if currRow[i-1]+1 < currRow[i] {
				currRow[i] = currRow[i-1] + 1
			} else if prevRow[i-1]+cost < currRow[i] {
				currRow[i] = prevRow[i-1] + cost
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

	var d int
	for i := 0; i < len(args); i++ {
		for j := 0; j < len(args); j++ {
			if i != j {
				if len(args[i]) == 0 {
					d = len(args[j])
				} else if len(args[j]) == 0 {
					d = len(args[i])
				} else if args[i] == args[j] {
					d = 0
				} else {
					d = levenshtein(args[i], args[j])
				}
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
