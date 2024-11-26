using System;

namespace CSharp
{
    class Code
    {
        static void Main(string[] args)
        {
            int u = int.Parse(args[0]); // Get an input number from the command line
            Random random = new Random();
            int r = random.Next(10000); // Get a random number 0 <= r < 10k
            int[] a = new int[10000]; // Array of 10k elements initialized to 0
            for (int i = 0; i < 10000; i++) // 10k outer loop iterations
            {
                for (int j = 0; j < 100000; j++) // 100k inner loop iterations, per outer loop iteration
                {
                    a[i] = a[i] + j % u; // Simple sum
                }
                a[i] += r; // Add a random value to each element in array
            }
            Console.WriteLine(a[r]); // Print out a single element from the array
        }
    }
}
