/**
 * @file
 * @brief This file uses Google style formatting.
 */

#include "benchmark.h"
#include "stdint.h"
#include "stdio.h"
#include "stdlib.h"
#include "time.h"

int loops(int u) {
  srand(time(NULL));                 // FIX random seed
  int r = rand() % 10000;            // Get a random integer 0 <= r < 10k
  int32_t a[10000] = {0};            // Array of 10k elements initialized to 0
  for (int i = 0; i < 10000; i++) {  // 10k outer loop iterations
    for (int j = 0; j < 10000;
         j++) {  // 10k inner loop iterations, per outer loop iteration
      a[i] = a[i] + j % u;  // Simple sum
    }
    a[i] += r;  // Add a random value to each element in array
  }
  return a[r];
}

// The work function that benchmark will time
static benchmark_result_t work(void* data) {
  int* u = (int*)data;
  int r = loops(*u);
  benchmark_result_t result = {.value.number = r};
  return result;
}

int main(int argc, char** argv) {
  int run_ms = atoi(argv[1]);
  int warmup_ms = atoi(argv[2]);
  int u = atoi(argv[3]);
  benchmark_run(work, &u, warmup_ms);
  benchmark_stats_t stats = benchmark_run(work, &u, run_ms);
  char buffer[1024];
  benchmark_format_results(stats, buffer, sizeof(buffer));
  printf("%s\n", buffer);
}
