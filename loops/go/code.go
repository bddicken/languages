// Hello there
//
// Go's main strenght is its concurrency model and writing go without that in mind is IMO a mistake
// i made some considerations since just spawning go routines would be careless,
// So I will be performing operation in batches
//
// Also int and uint types behave slightly differently in go. Here I choose to use uint because
// 1. Our values are guaranteed to be positive and so using uint results in more size and less chance of an overflow
// 2. by using uint (and not uint32 or uint64) you ensure that at compile time, values defualt to system arch size of say 32 or 64 bits
// 
// Naturally in Go slices would be much better for your problem but i decided to stick with arrays so i do not 
// deviate too much from your schema
//
// Your code also does something weird with the 
//  ... a[i] = a[i] + j%u ... and then ... a[i] += r ...     
// 
// Anyways my little contribution
package main

import (
	"fmt"
	"log"
	"math/rand"
	"os"
	"runtime"
	"strconv"
	"sync"
)

func init() {
	// I do not care about your machine or set defaults. We're using all cpus
	runtime.GOMAXPROCS(runtime.NumCPU())
}

func main() {
	// variable declarations
	var (
		array     [10000]uint // Array of 10k elements initialized to 0
		input     int
		err       error
		wg        sync.WaitGroup
		mtx       sync.Mutex
		batchsize uint = 1000
	)
	// get user input
	args := os.Args[1]

	// input validation
	if input, err = strconv.Atoi(args); err != nil {
		log.Printf("Error: Failed to covert input into an integer, %v", err)
		os.Exit(1) //exit
	}

	iter := uint(input)

	// Get a random number 0 <= r < 10k
	random := func() uint {
		return uint(rand.Intn(10000))
	}

	//create batch function
	batcher := func(start uint, array [10000]uint, wg *sync.WaitGroup, mtx *sync.Mutex) {
		defer wg.Done()

		for i := start; i < (start + batchsize); i++ {
			for j := uint(0); j < 100000; j++ {
				array[i] = j%iter // array[i] is set to zero so its a waste to look it up again
			}
			mtx.Lock()
			array[i] = random() // we use cycles to set the value only to overwrite it. hmm...
			mtx.Unlock()
		}
		return
	}

	// loop Logic
	wg.Add(len(array) / int(batchsize)) // array len is set so this is safe
	for i := uint(0); i < 10000; i += batchsize { // 10k outer loop iterations
		go batcher(i, array, &wg, &mtx)
	}

	wg.Wait()

	fmt.Println(array[random()])

}
