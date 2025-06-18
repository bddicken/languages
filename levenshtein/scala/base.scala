//> using scala 3.6.2

/**
 * Calculates the Levenshtein distance between strings using Wagner-Fischer algorithm
 * Space Complexity: O(min(m,n)) - only uses two arrays instead of full matrix
 * Time Complexity: O(m*n) where m and n are the lengths of the input strings
 */
object LevenshteinDistance {
  def levenshteinDistance(s1: String, s2: String): Int = {
    // Early termination checks
    if (s1 == s2) return 0
    if (s1.isEmpty) return s2.length
    if (s2.isEmpty) return s1.length

    // Make s1 the shorter string for space optimization
    val (str1, str2) = if (s1.length > s2.length) (s2, s1) else (s1, s2)

    val m = str1.length
    val n = str2.length

    // Use two arrays instead of full matrix for space optimization
    val prevRow = new Array[Int](m + 1)
    val currRow = new Array[Int](m + 1)

    // Initialize first row
    var i = 0
    while (i <= m) {
      prevRow(i) = i
      i += 1
    }

    // Convert strings to arrays for faster access
    val s1Chars = str1.toCharArray
    val s2Chars = str2.toCharArray

    // Main computation loop
    var j = 1
    while (j <= n) {
      currRow(0) = j

      i = 1
      while (i <= m) {
        val cost = if (s1Chars(i-1) == s2Chars(j-1)) 0 else 1
        
        // Calculate minimum of three operations
        currRow(i) = math.min(
          math.min(
            prevRow(i) + 1,      // deletion
            currRow(i-1) + 1     // insertion
          ),
          prevRow(i-1) + cost    // substitution
        )
        i += 1
      }

      // Swap rows
      System.arraycopy(currRow, 0, prevRow, 0, m + 1)
      j += 1
    }

    prevRow(m)
  }

  def run(args: Array[String]): Unit = {
    if (args.length < 2) {
      println("Please provide at least two strings as arguments.")
      return // Exit early
    }

    var minDistance = -1
    var times = 0

    // Compare all pairs of strings using while loops for better performance
    var i = 0
    while (i < args.length) {
      var j = 0
      while (j < args.length) {
        if (i != j) {
          val distance = levenshteinDistance(args(i), args(j))
          if (minDistance == -1 || distance < minDistance) {
            minDistance = distance
          }
          times += 1
        }
        j += 1
      }
      i += 1
    }

    println(s"times: $times")
    println(s"min_distance: $minDistance")
  }
}
