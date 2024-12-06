use fmt;
use os;
use strconv;
use math::random;
use time;

export fn main() void = {
	let u = strconv::stoi(os::args[1])!;
	let rng = random::init(time::unix(time::now(time::clock::REALTIME)): u64);
	let r = random::next(&rng) % 1000;
	let a: [10000]int = [0...];
	for(let i = 0; i < 10000; i+=1) {
		for(let j = 0; j < 100000; j+=1) {
			a[i] = a[i] + j%u;
		};
		a[i] += r: int;
	};
	fmt::printfln("{}", a[r])!;
};
