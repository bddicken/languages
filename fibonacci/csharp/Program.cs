static int Fibonacci(int n)
{
    if (n == 0) return 0;
    if (n == 1) return 1;
    return Fibonacci(n - 1) + Fibonacci(n - 2);
}

var u = int.Parse(args[0]);
var r = 0;

for (int i = 1; i < u; i++)
    r += Fibonacci(i);

Console.WriteLine(r);