import rand

@[direct_array_access]
fn main() {
	u := arguments()[1].i32() // Get an input number from the command line
	r := rand.i32_in_range(0, 10_000)! // Get a random integer 0 <= r < 10k
	mut a := [10000]i32{} // Array of 10k elements initialized to 0
	for i := 0; i < 10000; i++ { // 10k outer loop iterations
		for j := 0; j < 100000; j++ { // 100k inner loop iterations, per outer loop iteration
			a[i] = i32(a[i] + j % u) // Simple sum
		}
		a[i] += r // Add a random value to each element in array
	}
	println(a[r]) // Print out a single element from the array
}
