var u = int.Parse(args[0]);
var r = Random.Shared.Next(0, 10_000);
var a = new int[10_000];

for (var i = 0; i < 10_000; i++)
{
    for (int j = 0; j < 10_000; j++)
    {
        a[i] = a[i] + j % u;
    }
    a[i] += r;
}

Console.WriteLine(a[r]);