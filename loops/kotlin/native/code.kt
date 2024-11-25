import kotlin.random.Random

fun main(args: Array<String>) {
    val u: Int = args.get(0).toInt()
    val r: Int = Random.nextInt(10_000)
    val a = IntArray(10_000)
    for (i in 0 until 10_000) {
        for (j in 0 until 100_000) {
            a[i] = a[i] + j % u
        }
        a[i] = a[i] + r
    }
    println(a[r])
}
