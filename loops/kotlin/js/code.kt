import kotlin.random.Random

// node args not translated to main function args
// https://youtrack.jetbrains.com/issue/KT-41285
external val process: dynamic

fun main() {
    val nodeArg = process.argv[2] as String
    val u = nodeArg.toInt()            // Get an input number from the command line
    val r = Random.nextInt(10000) // Get a random number 0 <= r < 10k
    val a = IntArray(10000)       // Array of 10k elements initialized to 0
    for (i in 0..<10000) {          // 10k outer loop iterations
        for (j in 0..<100000) {     // 100k inner loop iterations, per outer loop iteration
            a[i] = a[i] + j % u        // Simple sum
        }
        a[i] += r                      // Add a random value to each element in array
    }
    println(a[r])                      // Print out a single element from the array
}