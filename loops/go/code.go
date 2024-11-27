package main

import (
	"fmt"
	"math/rand"
	"time"
)

func main() {
	const n = 10000
	const u = 100000
	a := make([]int, n)

	// Create a new random generator
	rng := rand.New(rand.NewSource(time.Now().UnixNano()))
	r := rng.Intn(10000) // Get a random number 0 <= r < 10k

	for i := 0; i < n; i++ { // 10k outer loop iterations
		for j := 0; j < u; j++ { // 100k inner loop iterations, per outer loop iteration
			a[i] += j % u // Simple sum
		}
		a[i] += r // Add a random value to each element in array
	}

	fmt.Println(a[r]) // Print out a single element from the array
}
