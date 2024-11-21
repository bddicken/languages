int fibonacci(int n) {
  if (n <= 1) return n;

  int a = 0, b = 1;
  for (int i = 2; i <= n; i++) {
    int temp = a + b;
    a = b;
    b = temp;
  }
  return b;
}

void main(List<String> arguments) {
  final u = int.parse(arguments[0]);

  var r = 0;
  for (var i = 0; i < u; i++) {
    r += fibonacci(i);
  }

  print(r);
}
