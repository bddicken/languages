import std.conv: to;
import std.stdio: writeln;
import std.random: Random, unpredictableSeed, uniform;

void main (string[] args) {
  int u = args[1].to!int;               // Get an input number from the command line
  auto rnd = Random(unpredictableSeed);
  int r = uniform(0, 10_000, rnd);              // Get a random integer 0 <= r < 10k
  int[10_000] a;              // Array of 10k elements initialized to 0
  foreach(i; 0..10_000) {
    foreach(j; 0..100_000)
      a[i] += j%u;               // Simple sum
    a[i] += r;                         // Add a random value to each element in array
  }
  writeln(a[r]);                // Print out a single element from the array
}
