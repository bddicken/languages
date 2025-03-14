package main

import (
	"fmt"
	"os"
	"strconv"
)

func fibonacci(n int) int {
	if n < 2 {
		return n
	}
	a, b := 0, 1
	for i := 2; i <= n; i++ {
		a, b = b, a+b
	}
	return b
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Uso: go run main.go <numero>")
		return
	}
	u, err := strconv.Atoi(os.Args[1])
	if err != nil {
		panic(err)
	}
	result := fibonacci(u+1) - 1

	fmt.Println(result)
}
