import std;

void main(string[] args) {
  int u = to!int(args[1]);             // Get an input number from the command line
  int r = uniform(0, 10000, rndGen) ;  // Get a random integer 0 <= r < 10k
  int[10000] a = 0;                    // Array of 10k elements initialized to 0
  for (int i = 0; i < 10000; i++) {    // 10k outer loop iterations
    for (int j = 0; j < 100000; j++) { // 100k inner loop iterations, per outer loop iteration
      a[i] = a[i] + j%u;               // Simple sum
    }
    a[i] += r;                         // Add a random value to each element in array
  }
  writeln(a[r]);                       // Print out a single element from the array  writeln(r);
}