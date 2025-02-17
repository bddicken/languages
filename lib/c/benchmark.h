/**
 * @file
 * @brief This file uses Google style formatting.
 */

#ifndef BENCHMARK_H
#define BENCHMARK_H

#include <stddef.h>
#include <stdint.h>

typedef union {
  int64_t number;
  void* ptr;
} benchmark_value_t;

typedef struct {
  benchmark_value_t value;
} benchmark_result_t;

typedef struct {
  double mean_ms;
  double std_dev_ms;
  double min_ms;
  double max_ms;
  int runs;
  benchmark_result_t last_result;
} benchmark_stats_t;

// Function pointer type for the work function
typedef benchmark_result_t (*benchmark_fn)(void* data);

// Format benchmark results into provided buffer
void benchmark_format_results(benchmark_stats_t stats, char* buffer,
                              size_t size);

// Main benchmarking function
benchmark_stats_t benchmark_run(benchmark_fn fn, void* data, int run_ms);

#endif  // BENCHMARK_H
