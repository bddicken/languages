int fibonacci(int n) {
  if (n == 0) return 0;
  if (n == 1) return 1;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

void main(List<String> args) {
  final u = int.parse(args[0]);
  int r = 0;

  for (int i = 0; i < u; i++) {
    r += fibonacci(i);
  }
  print(r);
}
