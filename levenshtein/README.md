# Levenshtein

This program computes the [levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance) between all of the strings provided on the command line.
It prints out the total number of strings compared for distance, and the lowest distance score of all comparisons.
All implementations must use the [Wagner-Fischer algorithm](https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm), with a few of the performance enhancements allowed:

- Reduced space complexity from O(m*n) to O(min(m,n)) by using only two rows instead of building full matrix
- Always use the shorter string for column dimension to minimize space usage
- Reuse arrays instead of creating new ones

This program emphasizes array/string access and basic looping and conditionals.

Below is the reference C program.
All languages should do the equivalent amount of work and meet these requirements:

```C
#include <stdio.h>
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

int levenshtein_distance(const char *str1t, const char *str2t) {
  // Get lengths of both strings
  int mt = strlen(str1t);
  int nt = strlen(str2t);
  // Assign shorter one to str1, longer one to str2
  const char* str1 = mt <= nt ? str1t : str2t;
  const char* str2 = mt <= nt ? str2t : str1t;
  // store the lengths of shorter in m, longer in n
  int m = str1 == str1t ? mt : nt;
  int n = str1 == str1t ? nt : mt;
 
  // Create two rows, previous and current
  int prev[m+1];
  int curr[m+1];
 
  // initialize the previous row
  for (int i = 0; i <= m; i++) {
    prev[i] = i;
  }

  // Iterate and compute distance
  for (int i = 1; i <= n; i++) {
    curr[0] = i;
    for (int j = 1; j <= m; j++) {
      int cost = (str1[j-1] == str2[i-1]) ? 0 : 1;
      curr[j] = min(
        prev[j] + 1,      // Deletion
        curr[j-1] + 1,    // Insertion
        prev[j-1] + cost  // Substitution
      );
    }
    for (int j = 0; j <= m; j++) {
      prev[j] = curr[j];
    }
  }
  
  // Return final distance, stored in prev[m]
  return prev[m];
}

int main(int argc, char *argv[]) {
  int min_distance = -1;
  int times = 0;
  // Iterate through all combinations of command line args
  for (int i = 1; i < argc; i++) {
    for (int j = 1; j < argc; j++) {
      // Don't compare the same string to itself
      if (i != j) {
        int distance = levenshtein_distance(argv[i], argv[j]);
        if (min_distance == -1 || min_distance > distance) {
          min_distance = distance;
        }
        times++;
      }
    }
  }
  
  // The only output from the program should be the times (number of comparisons) 
  // and min distance calculated of all comparisons. Two total lines of output, 
  // formatted exactly like this.
  printf("times: %d\n", times);
  printf("min_distance: %d\n", min_distance);
  
  return 0;
}
```
