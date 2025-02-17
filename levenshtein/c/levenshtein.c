#include "levenshtein.h"
#include <string.h>
#include <stdlib.h>

// Can either define your own min function
// or use a language / standard library function
int min(int a, int b, int c) {
  int min = a;
  if (b < min) min = b;
  if (c < min) min = c;
  return min;
}

/**
 * Calculates the Levenshtein distance between two strings using an optimized
 * version of Wagner-Fischer algorithm that uses O(min(m,n)) space.
 *
 * @param s1 The first string to compare
 * @param s2 The second string to compare
 * @return The Levenshtein distance between s1 and s2
 */

int levenshtein_distance(const char* s1, const char* s2) {
  // Get lengths of both strings
  int mt = strlen(s1);
  int nt = strlen(s2);
  // Assign shorter one to str1, longer one to str2
  const char* str1 = mt <= nt ? s1 : s2;
  const char* str2 = mt <= nt ? s2 : s1;
  // store the lengths of shorter in m, longer in n
  int m = str1 == s1 ? mt : nt;
  int n = str1 == s1 ? nt : mt;

  // Create two rows, previous and current
  int prev[m + 1];
  int curr[m + 1];

  // initialize the previous row
  for (int i = 0; i <= m; i++) {
    prev[i] = i;
  }

  // Iterate and compute distance
  for (int i = 1; i <= n; i++) {
    curr[0] = i;
    for (int j = 1; j <= m; j++) {
      int cost = (str1[j - 1] == str2[i - 1]) ? 0 : 1;
      curr[j] = min(prev[j] + 1,        // Deletion
                    curr[j - 1] + 1,    // Insertion
                    prev[j - 1] + cost  // Substitution
      );
    }
    for (int j = 0; j <= m; j++) {
      prev[j] = curr[j];
    }
  }

  // Return final distance, stored in prev[m]
  return prev[m];
}

distances_result_t* distances(char** words, int word_count) {
  distances_result_t* result = malloc(sizeof(distances_result_t));
  result->count = (word_count * (word_count - 1)) / 2;
  result->distances = malloc(result->count * sizeof(long));
  int idx = 0;

  for (int i = 0; i < word_count; i++) {
    for (int j = i + 1; j < word_count; j++) {
      result->distances[idx++] = levenshtein_distance(words[i], words[j]);
    }
  }
  return result;
}
