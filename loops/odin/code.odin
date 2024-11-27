package loops

import "core:fmt"
import "core:math/rand"
import "core:os"
import "core:strconv"

main :: proc() {
	u := strconv.atoi(os.args[1])
	r := rand.int_max(10000)
	a: [10000]int
	for i in 0 ..< 10000 {
		for j in 0 ..< 100000 {
			a[i] = a[i] + j % u
		}
		a[i] += r
	}
	fmt.println(a[r])
}
