fun fibonacci(n: Int): Int = fibonacciAccumulator(n, 0, 1)

fun fibonacciAccumulator(
    n: Int,
    a: Int,
    b: Int,
): Int {
    if (n == 0) return a
    return fibonacciAccumulator(n - 1, b, a + b)
}

fun main(args: Array<String>) {
    val u: Int = args.get(0).toInt()
    var r: Int = 0
    for (i in 1 until u) {
        r += fibonacci(i)
    }
    println(r)
}
