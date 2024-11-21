// See https://aka.ms/new-console-template for more information
class Program
{
    static void Main(string[] args)
    {
        int u = Int32.Parse(args[0]);
        Random random = new Random();

        int r = random.Next(0, 10000);

        int[] a = new int[10000];

        for (int i = 0; i < 10000; i++)
        {
            for (int j = 0; j < 10000; j++)
            {
                a[i] = a[i] + j % u;
            }

            a[i] += r;
        }

        Console.WriteLine(a[r]);
    }
}



