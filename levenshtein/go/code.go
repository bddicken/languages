package main

import (
	"fmt"
	"os"
)


func levenshtein(s1, s2 string) int {
    // Early termination
    if s1 == s2 {
        return 0
    }
    if len(s1) == 0 {
        return len(s2)
    }
    if len(s2) == 0 {
        return len(s1)
    }

    if len(s1) > len(s2) {
        s1, s2 = s2, s1
    }

    m, n := len(s1), len(s2)

    prevRow := make([]int, m+1)
    currRow := make([]int, m+1)

    for i := 0; i <= m; i++ {
        prevRow[i] = i
    }

    for j := 1; j <= n; j++ {
        currRow[0] = j
        for i := 1; i <= m; i++ {
            cost := 1
            if s1[i-1] == s2[j-1] {
                cost = 0
            }
            del := prevRow[i] + 1      // deletar char de s1
            ins := currRow[i-1] + 1    // inserir char em s1
            sub := prevRow[i-1] + cost // substituir char

            currRow[i] = del
            if ins < currRow[i] {
                currRow[i] = ins
            }
            if sub < currRow[i] {
                currRow[i] = sub
            }
        }
        prevRow, currRow = currRow, prevRow
    }

    return prevRow[m]
}

func main() {
    args := os.Args[1:]
    if len(args) < 2 {
        fmt.Println("Use: go run main.go <string1> <string2> [<string3> ...]")
        return
    }

    minD := -1
    times := 0

    for i := 0; i < len(args)-1; i++ {
        for j := i + 1; j < len(args); j++ {
            d := levenshtein(args[i], args[j])
            if minD == -1 || d < minD {
                minD = d
            }
            times++
        }
    }

    fmt.Printf("times: %d\n", times)
    fmt.Printf("min_distance: %d\n", minD)
}
