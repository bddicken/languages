var u = int.Parse(args[0]);
var r = Random.Shared.Next(10_000);

//Use span instead of array
Span<int> a = stackalloc int[10_000];

//using a.Length instead of 10_000 constant should give the compiler better optimization hints
for (var i = 0; i < a.Length; i++)
{
    for (var j = 0; j < 100_000; j++)
    {
        a[i] += j % u;
    }
    a[i] += r;
}
Console.WriteLine(a[r]);
