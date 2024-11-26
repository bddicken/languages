int u = int.Parse(args[0]);
int r = Random.Shared.Next(0, 10_000);
Span<int> a = stackalloc int[10_000];

for (int i = 0; i < 10_000; i++)
{
    for (int j = 0; j < 100_000; j++)
    {
        a[i] += j % u;
    }
    a[i] += r;  
}

Console.WriteLine(a[r]);