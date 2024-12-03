static int Fibonacci(int n) =>
    n <= 1 ? n : Fibonacci(n - 1) + Fibonacci(n - 2);

var u = int.Parse(args[0]);
var r = 0;
for (var i = 1; i < u; i++)
{
    r += Fibonacci(i);
}
Console.WriteLine(r);
