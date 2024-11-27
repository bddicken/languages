
// function fibonacci(n) {
//   if (n == 0) return 0;
//   if (n == 1) return 1;
//   return fibonacci(n-1) + fibonacci(n-2);
// }

// var u = Number(process.argv[2]);
// var r = 0;
// for (let i = 1; i < u; i++) {
//   r += fibonacci(i);
// }

//Reducción de complejidad computacional
function fibonacci(n, memo> = {}) {
    if (n in memo) return memo[n];
    if (n == 0) return 0;
    if (n == 1) return 1;
    memo[n] = fibonacci(n - 1, memo) + fibonacci(n - 2, memo);
    return memo[n];
}

var u = Number(process.argv[2]); // -> now test for example 100
var r = 0;
for (let i = 1; i < u; i++) {
    r += fibonacci(i);
}
console.log(r);
