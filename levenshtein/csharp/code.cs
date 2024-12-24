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

static int levenshtein(ReadOnlySpan<char> str1t, ReadOnlySpan<char> str2t)
{
    // Early termination checks
    if (str1t.SequenceEqual(str2t))
    {
        return 0;
    }
    if (str1t.IsEmpty)
    {
        return str2t.Length;
    }
    if (str2t.IsEmpty)
    {
        return str1t.Length;
    }
    // Get lengths of both strings
    int mt = str1t.Length;
    int nt = str2t.Length;
    // Assign shorter one to str1, longer one to str2
    ReadOnlySpan<char> str1 = mt <= nt ? str1t : str2t;
    ReadOnlySpan<char> str2 = mt <= nt ? str2t : str1t;
    // store the lengths of shorter in m, longer in n
    int m = str1 == str1t ? mt : nt;
    int n = str1 == str1t ? nt : mt;

    // Create two rows, previous and current
    Span<int> prev = stackalloc int[m + 1];
    Span<int> curr = stackalloc int[m + 1];

    // initialize the previous row
    for (int i = 0; i <= m; i++)
    {
        prev[i] = i;
    }

    // Iterate and compute distance
    for (int i = 1; i <= n; i++)
    {
        curr[0] = i;
        for (int j = 1; j <= m; j++)
        {
            int cost = (str1[j - 1] == str2[i - 1]) ? 0 : 1;
            curr[j] = Math.Min(
              prev[j] + 1,      // Deletion
              Math.Min(curr[j - 1] + 1,    // Insertion
              prev[j - 1] + cost)  // Substitution
            );
        }
        for (int j = 0; j <= m; j++)
        {
            prev[j] = curr[j];
        }
    }

    // Return final distance, stored in prev[m]
    return prev[m];
}
