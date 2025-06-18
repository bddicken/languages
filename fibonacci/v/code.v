fn fibonacci(n i32) i32 {
	if n == 0 {
		return 0
	}
	if n == 1 {
		return 1
	}
	return fibonacci(n - 1) + fibonacci(n - 2)
}

@[direct_array_access]
fn main() {
	u := arguments()[1].i32()
	mut r := i32(0)
	for i := i32(1); i < u; i++ {
		r += fibonacci(i)
	}
	println(r)
}
