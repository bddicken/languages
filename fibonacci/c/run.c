/**
 * @file
 * @brief This file uses Google style formatting.
 */

#include "benchmark.h"
#include "stdint.h"
#include "stdio.h"
#include "stdlib.h"
#include "fibonacci.h" 

// The work function that benchmark will time
static benchmark_result_t work(void* data) {
  int* n = (int*)data;
  int r = fibonacci(*n);
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
