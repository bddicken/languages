
function fibonacci(n) {
  return fibonacci_accumulator(n, 0, 1);
}

function fibonacci_accumulator(n, a, b) {
  if (n == 0) return a;
  return fibonacci_accumulator(n - 1, b, a + b);
}

var u = Number(process.argv[2]);
var r = 0;
for (let i = 1; i < u; i++) {
  r += fibonacci(i);
}
console.log(r);
