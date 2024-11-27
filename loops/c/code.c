#include "stdio.h"
#include "stdlib.h"
#include "stdint.h"

int main (int argc, char** argv) {
  int u = atoi(argv[1]);               // Get an input number from the command line
  int r = rand() % 10000;              // Get a random integer 0 <= r < 10k
  int32_t a[10000] = {0};              // Array of 10k elements initialized to 0
  int32_t* arr_ptr = &a[0];            // Set pointer to start of array
  for (int i = 0; i < 10000; i++) {    // 10k outer loop iterations
    for (int j = 0; j < 100000; j++) { // 100k inner loop iterations, per outer loop iteration
      *arr_ptr += j%u;                 // Simple sum
    }
    *arr_ptr += r;                     // Add a random value to each element in array
    arr_ptr++;                         // Move array pointer forward
  }
  printf("%d\n", a[r]);                // Print out a single element from the array
}
