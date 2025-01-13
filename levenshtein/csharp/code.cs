using System.Runtime.CompilerServices;

var minDistance = int.MaxValue;
var times = 0;
for (var i = 0; i < args.Length; i++)
{
    for (var j = 0; j < args.Length; j++)
    {
        if (i != j)
        {
            var distance = LevenshteinDistance(args[i], args[j]);
            if (minDistance > distance)
            {
                minDistance = distance;
            }

            times++;
        }
    }
}

Console.WriteLine($"times: {times}");
Console.WriteLine($"min_distance: {minDistance}");
return;

[MethodImpl(MethodImplOptions.AggressiveOptimization)]
static int LevenshteinDistance(string str1, string str2)
{
    // Early termination checks
    if (str1 == str2)
    {
        return 0;
    }

    if (string.IsNullOrEmpty(str1))
    {
        return str2.Length;
    }

    if (string.IsNullOrEmpty(str2))
    {
        return str1.Length;
    }

    // Ensure str1 is the shorter string
    if (str1.Length > str2.Length)
    {
        (str1, str2) = (str2, str1);
    }

    var m = str1.Length;
    var n = str2.Length;

    // Create two rows, previous and current
    var prev = new int[m + 1];
    var curr = new int[m + 1];

    // Iterate and compute distance
    for (var i = 1; i <= n; i++)
    {
        curr[0] = i;
        for (var j = 1; j <= m; j++)
        {
            var cost = str1[j - 1] == str2[i - 1] ? 0 : 1;
            curr[j] = Math.Min(
                prev[j] + 1, // Deletion
                Math.Min(curr[j - 1] + 1, // Insertion
                    prev[j - 1] + cost) // Substitution
            );
        }

        // Swap arrays
        (prev, curr) = (curr, prev);
    }

    // Return final distance, stored in prev[m]
    return prev[m];
}
