fun fibonacci(n: Int): Int {
    if (n == 0) return 0
    if (n == 1) return 1
    return fibonacci(n-1) + fibonacci(n-2)
}

fun main(args: Array<String>) {
    val u: Int = args.get(0).toInt()
    var r: Int = 0
    for (i in 1 until u) {
        r += fibonacci(i)
    }
    println(r)
}

