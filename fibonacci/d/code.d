import std;

int fibonacci(int n) pure {
  if (n == 0) return 0;
  if (n == 1) return 1;
  return fibonacci(n-1) + fibonacci(n-2);
}

void main(string[] args) {
  int u = to!int(args[1]);
  int r = 0;
  for (int i = 1; i < u; i++) {
    r += fibonacci(i);
  }
  writeln(r);
}