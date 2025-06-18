import 'dart:math';

int levenshteinDistance(String word1, String word2) {
  final m = word1.length;
  final n = word2.length;
  // Create a matrix to store distances
  var matrix = List.generate(m+1, (i) => List.generate(n+1, (j) => 0));

  // Initialize first row and column 
  for (int i = 1; i <= m; i++) {
      matrix[i][0] = i;
  }
  for (int j = 1; j <= n; j++) {
      matrix[0][j] = j;
  }
  
  // Compute Levenshtein distance
  for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        int cost = word1[i-1] == word2[j-1]? 0:1;
        matrix[i][j] = min(
            min(
                matrix[i-1][j] + 1, // Deletion
                matrix[i][j-1] + 1  // Insertion
            ),
            matrix[i-1][j-1] + cost // Substitution
        );
      }
  }
  return matrix[m][n];
}

void main(List<String> args) {
  if (args.length < 2) {
    print("Usage: dart code <string1> <string2> ...");
    return;
  }

  int minDistance = -1;
  int times = 0;
  // Compare each pair of arguments exactly once
  for (int i = 0; i < args.length; i++) {
      for (int j = i+1; j < args.length; j++) {
        if (i != j) {
            int distance = levenshteinDistance(args[i], args[j]);
            if (minDistance == -1 || distance < minDistance ) {
                minDistance = distance;
            }
            times++;
        }
      }
  }

  // The only output from the program should be the times (number of comparisons)
  // and min distance calculated of all comparisons. Two total lines of output,
  // formatted exactly like this.
  print("times: " + times.toString());
  print("min_distance: " + minDistance.toString());
}