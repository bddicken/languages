int u = int.Parse(args[0]);
int r = 0;
for (int i = 1; i < u; i++)
    r += Fibonacci(i);

Console.WriteLine(r);

static int Fibonacci(int n)
{
    if (n == 0) return 0;
    if (n == 1) return 1;
    return Fibonacci(n - 1) + Fibonacci(n - 2);
}
