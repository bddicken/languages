int u = int.Parse(args[0]);
int r = 0;

for (int i = 0; i < u; i++)
{
    r += Fibonacci(i);
}

Console.WriteLine(r);
return;

static int Fibonacci(int n)
{
    return n switch
    {
        0 => 0,
        1 => 1,
        _ => Fibonacci(n - 1) + Fibonacci(n - 2)
    };
}