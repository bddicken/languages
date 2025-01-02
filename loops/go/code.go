package main

import (
	"fmt"
	"math/rand"
	"os"
	"strconv"
)

func main() {
    input, e := strconv.Atoi(os.Args[1])
    if e != nil {
        panic(e)
    }
    u := int32(input)
    var soma int32
    for j := int32(0); j < 100000; j++ {
        soma += j % u
    }
    r := rand.Int31n(10000)
    var a [10000]int32
    for i := int32(0); i < 10000; i++ {
        a[i] = soma + r
    }
    fmt.Println(a[r])
}
