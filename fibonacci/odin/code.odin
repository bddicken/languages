package main

import "core:fmt"
import "core:os"
import "core:strconv"

fibonacci :: proc(n: int) -> int {
    if n == 0 do return 0
    if n == 1 do return 1
    return fibonacci(n-1) + fibonacci(n-2)
}

main :: proc() {
    u := strconv.atoi(os.args[1])
    r := 0
    for i in 1..<u {
        r += fibonacci(i)
    }
    fmt.println(r)
}
