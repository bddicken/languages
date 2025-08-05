using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

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

    ref char str1Ref = ref MemoryMarshal.GetReference(str1);
    ref char str2Ref = ref MemoryMarshal.GetReference(str2);

    // Create two rows, previous and current
    Span<int> prev = stackalloc int[str1.Length + 1];
    Span<int> curr = stackalloc int[str1.Length + 1];
    ref int prevRef = ref MemoryMarshal.GetReference(prev);
    ref int currRef = ref MemoryMarshal.GetReference(curr);

    // initialize the previous row
    for (int i = 0; i < prev.Length; i++)
    {
        Unsafe.Add(ref prevRef , i) = i;
    }

    // Iterate and compute distance
    for (int i = 0; i < str2.Length; i++)
    {
        currRef = i + 1;
        for (int j = 0; j < str1.Length; j++)
        {
            int cost = Unsafe.Add(ref str1Ref, j) == Unsafe.Add(ref str2Ref, i) ? 0 : 1;
            Unsafe.Add(ref currRef, j + 1) = Math.Min(
                Unsafe.Add(ref prevRef, j + 1) + 1, // Deletion
                Math.Min(Unsafe.Add(ref currRef, j) + 1, // Insertion
                    Unsafe.Add(ref prevRef, j) + cost) // Substitution
            );
        }

        ++i;
        if (i >= str2.Length)
        {
            break;
        }

        // prevRef and currRef are swapped
        prevRef = i + 1;
        for (int j = 0; j < str1.Length; j++)
        {
            int cost = Unsafe.Add(ref str1Ref, j) == Unsafe.Add(ref str2Ref, i) ? 0 : 1;
            Unsafe.Add(ref prevRef, j + 1) = Math.Min(
                Unsafe.Add(ref currRef, j + 1) + 1, // Deletion
                Math.Min(Unsafe.Add(ref prevRef, j) + 1, // Insertion
                    Unsafe.Add(ref currRef, j) + cost) // Substitution
            );
        }
    }

    // Return final distance, stored in
    // prev[m] if str2 length is even or in
    // curr[m] if str2 length is odd
    return Unsafe.Add(ref ((str2.Length & 1) == 0) ? ref prevRef : ref currRef, str1.Length);
}