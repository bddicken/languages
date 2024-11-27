using System;

class Program
{
    static void Main(string[] args)
    {
        var u = int.Parse(args[0]);               // Get an input number from the command line
        Random random = new Random();
        var r = random.Next(0, 10000);            // Get a random integer 0 <= r < 10k
        var a = new int[10000];                // Array of 10k elements initialized to 0
        for (int i = 0; i < 10000; i++)          // 10k outer loop iterations
        {
            for (int j = 0; j < 100000; j++)     // 100k inner loop iterations, per outer loop iteration
            {
                a[i] = a[i] + j % u;             // Simple sum
            }
            a[i] += r;                           // Add a random value to each element in array
        }
        Console.WriteLine(a[r]);                 // Print out a single element from the array
    }
}
