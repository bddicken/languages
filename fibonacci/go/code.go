package main

import (
	"fmt"
	"os"
	"strconv"
)

func main() {
	input, e := strconv.Atoi(os.Args[1])
	if e != nil {
		panic(e)
	}

	var r int

	f := fibonacci()
	for i := 0; i < input; i++ {
		r += f()
	}

	fmt.Println(r)
}

func fibonacci() func() int {
	a := 0
	b := 1
	return func() int {
		a, b = b, a+b
		return b - a
	}
}
