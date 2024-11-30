package jvm

@main
def main(number: String): Unit =
  val u = number.toInt
  var r = 0
  for i <- 1 until u do
    r += fibonacci(i)
  println(r)


def fibonacci(n: Int): Int =
  n match
    case 0 => 0
    case 1 => 1
    case _ => fibonacci(n - 1) + fibonacci(n - 2)
