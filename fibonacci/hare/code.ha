use fmt;
use os;
use strconv;

fn fibonacci(n: uint) uint = {
	if (n == 0) return 0;
	if (n == 1) return 1;
	return fibonacci(n-1) + fibonacci(n-1);	
};

export fn main() void = {
	let u = strconv::stou(os::args[1])!;
	let r: uint = 0;
	for (let i: uint = 1; i < u; i+=1) {
		r += fibonacci(i);	
	};
	fmt::printfln("{}", r)!;
};
