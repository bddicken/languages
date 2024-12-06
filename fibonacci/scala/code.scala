//> using scala 3.6.1

package jvm

import scala.annotation.switch

@main
def main(number: String): Unit =
  val u = number.toInt
  var r = 0
  var i = 0
  while i < u do
    r += fibonacci(i)
    i += 1
  println(r)

def fibonacci(n: Int): Int =
  (n: @switch) match
    case 0 => 0
    case 1 => 1
    case _ => fibonacci(n - 1) + fibonacci(n - 2)
