/**
 * @file
 * @brief This file uses Google style formatting.
 */

/**
 * This program implements the Levenshtein distance algorithm and provides
 * functionality to benchmark it with the following features:
 * - Reads words from an input file
 * - Calculates Levenshtein distances between all unique pairs
 * - Returns sum of all distances as final result
 * - Provides benchmark statistics in CSV format
 *
 * The program takes two command line arguments:
 * 1. run_ms: How long to run the benchmark in milliseconds
 * 2. input_file: Path to file containing space-separated words
 *
 * Output format: mean_ms,std_dev_ms,min_ms,max_ms,runs,result
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "benchmark.h"
#include "levenshtein.h"

static char** read_words(const char* filename, int* word_count) {
  // First read entire file content
  FILE* file = fopen(filename, "r");
  if (!file) {
    fprintf(stderr, "Could not open file: %s\n", filename);
    exit(1);
  }

  // Get file size
  fseek(file, 0, SEEK_END);
  long file_size = ftell(file);
  fseek(file, 0, SEEK_SET);

  // Read entire file into buffer
  char* content = malloc(file_size + 1);
  fread(content, 1, file_size, file);
  content[file_size] = '\0';
  fclose(file);

  // Count words (space separated)
  int capacity = 100;
  char** words = malloc(capacity * sizeof(char*));
  *word_count = 0;

  // Split on lines
  char* word = strtok(content, "\n");
  while (word != NULL) {
    if (*word_count == capacity) {
      capacity *= 2;
      words = realloc(words, capacity * sizeof(char*));
    }
    words[*word_count] = strdup(word);
    (*word_count)++;
    word = strtok(NULL, "\n");
  }

  free(content);
  return words;
}


typedef struct {
  char** words;
  int count;
} word_data_t;

// The work function that benchmark will time
static benchmark_result_t work(void* data) {
  word_data_t* word_data = (word_data_t*)data;
  distances_result_t* result_distances = distances(word_data->words, word_data->count);
  benchmark_result_t result = {.value.ptr = result_distances};
  return result;
}

int main(int argc, char* argv[]) {
  if (argc != 4) {
    fprintf(stderr, "Usage: %s <run_ms> <warmup_ms> <input_file>\n", argv[0]);
    return 1;
  }

  int run_ms = atoi(argv[1]);
  int warmup_ms = atoi(argv[2]);
  int word_count;
  char** words = read_words(argv[3], &word_count);

  word_data_t data = {words, word_count};

  benchmark_run(work, &data, warmup_ms);

  benchmark_stats_t stats = benchmark_run(work, &data, run_ms);
  // Sum the distances outside the benchmarked function
  distances_result_t* distances =
      (distances_result_t*)stats.last_result.value.ptr;
  long sum = 0;
  for (int i = 0; i < distances->count; i++) {
    sum += distances->distances[i];
  }
  stats.last_result.value.number = sum;

  char buffer[1024];
  benchmark_format_results(stats, buffer, sizeof(buffer));
  printf("%s\n", buffer);

  // Clean up everything
  free(distances->distances);
  free(distances);
  for (int i = 0; i < word_count; i++) {
    free(words[i]);
  }
  free(words);

  return 0;
}
