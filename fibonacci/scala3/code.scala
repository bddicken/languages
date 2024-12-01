def fibonacci(n: Int): Int =
  if (n < 2) n else fibonacci(n-1) + fibonacci(n-2)

@main def code(n: Int): Unit =
  println ((1 until n map fibonacci).sum)


