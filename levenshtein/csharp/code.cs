using System.Runtime.CompilerServices;

int min_distance = -1;
int times = 0;
for (int i = 0; i < args.Length; i++)
{
    for (int j = 0; j < args.Length; j++)
    {
        if (i != j)
        {
            int distance = levenshtein(args[i], args[j]);
            if (min_distance == -1 || min_distance > distance)
            {
                min_distance = distance;
            }
            times++;
        }
    }
}
Console.WriteLine($"times: {times}");
Console.WriteLine($"min_distance: {min_distance}");

[MethodImpl(MethodImplOptions.AggressiveOptimization)]
static int levenshtein(ReadOnlySpan<char> str1, ReadOnlySpan<char> str2)
{
    // Early termination checks
    if (str1.SequenceEqual(str2))
    {
        return 0;
    }
    if (str1.IsEmpty)
    {
        return str2.Length;
    }
    if (str2.IsEmpty)
    {
        return str1.Length;
    }

    // Ensure str1 is the shorter string
    if (str1.Length > str2.Length)
    {
        var strtemp = str2;
        str2 = str1;
        str1 = strtemp;
    }

    // Create two rows, previous and current
    Span<int> prev = stackalloc int[str1.Length + 1];
    Span<int> curr = stackalloc int[str1.Length + 1];

    // initialize the previous row
    for (int i = 0; i <= str1.Length; i++)
    {
        prev[i] = i;
    }

    // Iterate and compute distance
    for (int i = 1; i <= str2.Length; i++)
    {
        curr[0] = i;
        for (int j = 1; j <= str1.Length; j++)
        {
            int cost = (str1[j - 1] == str2[i - 1]) ? 0 : 1;
            curr[j] = Math.Min(
              prev[j] + 1,      // Deletion
              Math.Min(curr[j - 1] + 1,    // Insertion
              prev[j - 1] + cost)  // Substitution
            );
        }

        // Swap spans
        var temp = prev;
        prev = curr;
        curr = temp;
    }
    
    // Return final distance, stored in prev[m]
    return prev[str1.Length];
}
