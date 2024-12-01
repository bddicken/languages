import std.stdio: writeln;
import std.conv: to;

int fibonacci(int n) {
  if (n < 2)
      return n;
  return fibonacci(n-1) + fibonacci(n-2);
}

void main (string[] args) {
  int u = args[1].to!int;
  int r;
  foreach(i; 1..u)
    r += fibonacci(i);

  writeln(r);
}
