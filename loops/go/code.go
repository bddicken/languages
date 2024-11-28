package main

import (
	"fmt"
	"math/rand"
	"os"
	"strconv"
)

func main() {
	// Parse input argument without error checking
	u, _ := strconv.Atoi(os.Args[1])

	// Initialize constants and variables
	const arraySize = 10000
	const innerLoopCount = 100000
	r := rand.Intn(arraySize) // Random number 0 <= r < arraySize
	a := make([]int, arraySize)

	// Precompute values to avoid repeated calculations
	modVals := make([]int, innerLoopCount)
	for j := 0; j < innerLoopCount; j++ {
		modVals[j] = j % u
	}

	// Main computation loop
	for i := 0; i < arraySize; i++ {
		sum := 0
		for j := 0; j < innerLoopCount; j++ {
			sum += modVals[j]
		}
		a[i] = sum + r
	}

	fmt.Println(a[r])
}