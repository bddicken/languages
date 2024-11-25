int u = int.Parse(args[0]);
int r = Random.Shared.Next(0, 10000);
int[] a = new int[10000];

for (int i = 0; i < 10000; i++)
{
    for (int j = 0; j < 100000; j++)
    {
        a[i] += j % u;
    }
    a[i] += r;  
}

Console.WriteLine(a[r]);