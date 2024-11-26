int fibonacci(int n) {
  return fibonacci_accumulator(n, 0, 1);
}

int fibonacci_accumulator(int n, int a, int b) {
  if (n == 0) return a;
  return fibonacci_accumulator(n - 1, b, a + b);
}

void main(List<String> args) {
  final u = int.parse(args[0]);
  int r = 0;

  for (int i = 0; i < u; i++) {
    r += fibonacci(i);
  }
  print(r);
}
