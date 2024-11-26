package main

import (
  "fmt"
  "os"
  "strconv"
)

func fibonacci(n int) int {
  return fibbonaciAccumulator(n, 0, 1)
}
func fibbonaciAccumulator(n int, a int, b int) int {
  if n == 0 {
    return a
  }
  return fibbonaciAccumulator(n-1, b, a+b)
}

func main() {
  input, e := strconv.Atoi(os.Args[1])
  if e != nil {
    panic(e)
  }
  u := int(input)
  r := 0
  for i := 0; i < u; i++ {
    r += fibonacci(i)
  }
  fmt.Println(r)
}
