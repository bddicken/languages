using System.Runtime.CompilerServices;

var runMs = int.Parse(args[0]);
var warmupMs = int.Parse(args[1]);
var inputPath = args[2];

var content = File.ReadAllLines(inputPath);

Benchmark<List<int>>.Run(() => Levenshtein(content), warmupMs);

var result = Benchmark<List<int>>.Run(() => Levenshtein(content), runMs);

var summedResult = new BenchmarkResult<int>(
    result!.MeanMs,
    result.StdDevMs,
    result.MinMs,
    result.MaxMs,
    result.Runs,
    result.Result.Sum());

Console.WriteLine(summedResult);

return;

static List<int> Levenshtein(string[] content)
{
    var distances = new List<int>();

    for (var i = 0; i < content.Length; i++)
    {
        for (var j = i + 1; j < content.Length; j++)
        {
            distances.Add(LevenshteinDistance(content[i], content[j]));
        }
    }

    return distances;
}

[MethodImpl(MethodImplOptions.AggressiveOptimization)]
static int LevenshteinDistance(ReadOnlySpan<char> str1, ReadOnlySpan<char> str2)
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
    for (var i = 0; i <= str1.Length; i++)
    {
        prev[i] = i;
    }

    // Iterate and compute distance
    for (var i = 1; i <= str2.Length; i++)
    {
        curr[0] = i;
        for (var j = 1; j <= str1.Length; j++)
        {
            var cost = (str1[j - 1] == str2[i - 1]) ? 0 : 1;
            curr[j] = Math.Min(
                prev[j] + 1, // Deletion
                Math.Min(curr[j - 1] + 1, // Insertion
                    prev[j - 1] + cost) // Substitution
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
